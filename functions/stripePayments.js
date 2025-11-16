const functions = require('firebase-functions');
const admin = require('firebase-admin');
const Stripe = require('stripe');

// Initialize Stripe with secret key from Firebase Functions config
// Set via: firebase functions:config:set stripe.secret_key="sk_test_..."
const stripe = Stripe(process.env.STRIPE_SECRET_KEY || functions.config().stripe?.secret_key || '');

const db = admin.firestore();

/**
 * Create Payment Intent for event booking
 * Called from Flutter app before showing payment sheet
 */
exports.createPaymentIntent = functions.https.onCall(async (data, context) => {
  // Verify user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  try {
    const { amount, currency, eventId, userId, eventName } = data;

    // Validate inputs
    if (!amount || !currency || !eventId || !userId) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Missing required parameters'
      );
    }

    // Verify event exists and is active
    const eventDoc = await db.collection('events').doc(eventId).get();
    if (!eventDoc.exists) {
      throw new functions.https.HttpsError('not-found', 'Event not found');
    }

    const event = eventDoc.data();
    if (!event.isActive) {
      throw new functions.https.HttpsError('failed-precondition', 'Event is not active');
    }

    // Check if event is full
    if (event.attendeeIds && event.attendeeIds.length >= event.maxAttendees) {
      throw new functions.https.HttpsError('failed-precondition', 'Event is full');
    }

    // Create Stripe Payment Intent
    const paymentIntent = await stripe.paymentIntents.create({
      amount: amount, // Amount in cents
      currency: currency.toLowerCase(),
      metadata: {
        eventId: eventId,
        userId: userId,
        eventName: eventName || '',
        integration_check: 'accept_a_payment',
      },
      automatic_payment_methods: {
        enabled: true,
      },
      description: `Booking for ${eventName || 'event'} - MySheTribe`,
    });

    console.log(`Payment intent created: ${paymentIntent.id} for event: ${eventId}`);

    return {
      clientSecret: paymentIntent.client_secret,
      paymentIntentId: paymentIntent.id,
    };
  } catch (error) {
    console.error('Error creating payment intent:', error);

    if (error instanceof functions.https.HttpsError) {
      throw error;
    }

    throw new functions.https.HttpsError('internal', error.message);
  }
});

/**
 * Confirm payment status
 * Called after payment sheet is dismissed to verify payment succeeded
 */
exports.confirmPaymentStatus = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  try {
    const { paymentIntentId } = data;

    if (!paymentIntentId) {
      throw new functions.https.HttpsError('invalid-argument', 'Payment Intent ID is required');
    }

    // Retrieve payment intent from Stripe
    const paymentIntent = await stripe.paymentIntents.retrieve(paymentIntentId);

    return {
      status: paymentIntent.status,
      amount: paymentIntent.amount,
      currency: paymentIntent.currency,
      metadata: paymentIntent.metadata,
    };
  } catch (error) {
    console.error('Error confirming payment status:', error);
    throw new functions.https.HttpsError('internal', error.message);
  }
});

/**
 * Process refund for cancelled bookings
 */
exports.refundPayment = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  try {
    const { paymentIntentId, amount, reason } = data;

    if (!paymentIntentId) {
      throw new functions.https.HttpsError('invalid-argument', 'Payment Intent ID is required');
    }

    // Create refund
    const refund = await stripe.refunds.create({
      payment_intent: paymentIntentId,
      amount: amount, // Optional - refunds full amount if not specified
      reason: reason || 'requested_by_customer',
    });

    console.log(`Refund created: ${refund.id} for payment intent: ${paymentIntentId}`);

    return {
      success: true,
      refundId: refund.id,
      status: refund.status,
      amount: refund.amount,
    };
  } catch (error) {
    console.error('Error processing refund:', error);
    throw new functions.https.HttpsError('internal', error.message);
  }
});

/**
 * Webhook handler for Stripe events
 * This is triggered by Stripe when payment events occur
 * Configure webhook URL in Stripe Dashboard: https://dashboard.stripe.com/webhooks
 */
exports.stripeWebhook = functions.https.onRequest(async (req, res) => {
  const sig = req.headers['stripe-signature'];
  const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET || functions.config().stripe?.webhook_secret;

  let event;

  try {
    event = stripe.webhooks.constructEvent(req.rawBody, sig, webhookSecret);
  } catch (err) {
    console.error('Webhook signature verification failed:', err.message);
    return res.status(400).send(`Webhook Error: ${err.message}`);
  }

  // Handle the event
  try {
    switch (event.type) {
      case 'payment_intent.succeeded':
        const paymentIntent = event.data.object;
        console.log(`Payment succeeded: ${paymentIntent.id}`);

        // Update booking status in Firestore
        const { eventId, userId } = paymentIntent.metadata;
        if (eventId && userId) {
          // Find booking by payment intent ID
          const bookingsQuery = await db.collection('bookings')
            .where('stripePaymentIntentId', '==', paymentIntent.id)
            .limit(1)
            .get();

          if (!bookingsQuery.empty) {
            const bookingDoc = bookingsQuery.docs[0];
            await bookingDoc.ref.update({
              status: 'confirmed',
              updatedAt: admin.firestore.FieldValue.serverTimestamp(),
            });

            console.log(`Booking ${bookingDoc.id} confirmed for payment ${paymentIntent.id}`);
          }
        }
        break;

      case 'payment_intent.payment_failed':
        const failedPayment = event.data.object;
        console.log(`Payment failed: ${failedPayment.id}`);

        // Update booking status to failed/cancelled
        const failedBookingsQuery = await db.collection('bookings')
          .where('stripePaymentIntentId', '==', failedPayment.id)
          .limit(1)
          .get();

        if (!failedBookingsQuery.empty) {
          const bookingDoc = failedBookingsQuery.docs[0];
          await bookingDoc.ref.update({
            status: 'cancelled',
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
        }
        break;

      case 'charge.refunded':
        const refundedCharge = event.data.object;
        console.log(`Charge refunded: ${refundedCharge.id}`);

        // Update booking status to refunded
        const refundedBookingsQuery = await db.collection('bookings')
          .where('stripePaymentIntentId', '==', refundedCharge.payment_intent)
          .limit(1)
          .get();

        if (!refundedBookingsQuery.empty) {
          const bookingDoc = refundedBookingsQuery.docs[0];
          await bookingDoc.ref.update({
            status: 'cancelled',
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
        }
        break;

      default:
        console.log(`Unhandled event type ${event.type}`);
    }

    res.json({ received: true });
  } catch (error) {
    console.error('Error handling webhook event:', error);
    res.status(500).send('Webhook handler failed');
  }
});
