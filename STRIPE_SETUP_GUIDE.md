# Stripe Payment Integration Setup Guide

## Overview
This guide explains how to set up and configure Stripe payments for MySheTribe event bookings.

## Architecture
- **Frontend**: Flutter app uses `flutter_stripe` package to present payment sheets
- **Backend**: Firebase Cloud Functions handle payment intent creation and webhooks
- **Payment Flow**: Event booking → Stripe payment → Booking confirmation

## Prerequisites
1. Stripe account (sign up at https://stripe.com)
2. Firebase project with Cloud Functions enabled
3. OpenAI API key already configured (for AI matching)

---

## Step 1: Get Stripe API Keys

### 1.1 Create Stripe Account
1. Go to https://dashboard.stripe.com/register
2. Complete registration and verify your email

### 1.2 Get API Keys
1. Go to https://dashboard.stripe.com/apikeys
2. You'll see two types of keys:
   - **Publishable key** (starts with `pk_test_...` for test mode)
   - **Secret key** (starts with `sk_test_...` for test mode)

**IMPORTANT**: Never commit secret keys to git!

---

## Step 2: Configure Stripe in Flutter App

### 2.1 Update main.dart
Replace the placeholder publishable key in `lib/main.dart`:

```dart
await StripeService().initialize(
  'pk_test_YOUR_ACTUAL_KEY_HERE', // Replace with your publishable key
);
```

### 2.2 Install Dependencies
```bash
flutter pub get
```

---

## Step 3: Configure Stripe in Cloud Functions

### 3.1 Set Stripe Secret Key
```bash
firebase functions:config:set stripe.secret_key="sk_test_YOUR_SECRET_KEY_HERE"
```

### 3.2 Set Stripe Webhook Secret (Optional for webhooks)
```bash
firebase functions:config:set stripe.webhook_secret="whsec_YOUR_WEBHOOK_SECRET"
```

### 3.3 Install Dependencies
```bash
cd functions
npm install
cd ..
```

---

## Step 4: Deploy Cloud Functions

### 4.1 Deploy All Functions
```bash
firebase deploy --only functions
```

This will deploy:
- `createPaymentIntent` - Creates payment intent for event booking
- `confirmPaymentStatus` - Confirms payment status
- `refundPayment` - Processes refunds for cancelled bookings
- `stripeWebhook` - Handles Stripe webhook events
- (Plus existing AI matching functions)

### 4.2 Verify Deployment
Check Firebase Console:
https://console.firebase.google.com/project/myshetribe/functions

---

## Step 5: Configure Stripe Webhooks (Recommended)

Webhooks automatically update booking status when payments succeed or fail.

### 5.1 Get Webhook URL
Your webhook URL format:
```
https://us-central1-myshetribe.cloudfunctions.net/stripeWebhook
```

### 5.2 Add Webhook in Stripe Dashboard
1. Go to https://dashboard.stripe.com/webhooks
2. Click "Add endpoint"
3. Enter your webhook URL
4. Select events to listen for:
   - `payment_intent.succeeded`
   - `payment_intent.payment_failed`
   - `charge.refunded`
5. Click "Add endpoint"

### 5.3 Get Webhook Signing Secret
1. Click on your newly created webhook
2. Click "Reveal" under "Signing secret"
3. Copy the secret (starts with `whsec_...`)
4. Set it in Firebase:
```bash
firebase functions:config:set stripe.webhook_secret="whsec_YOUR_SECRET_HERE"
firebase deploy --only functions
```

---

## Step 6: Test Payment Flow

### 6.1 Use Test Cards
Stripe provides test cards for development:

**Successful Payment:**
- Card number: `4242 4242 4242 4242`
- Expiry: Any future date (e.g., 12/34)
- CVC: Any 3 digits (e.g., 123)
- ZIP: Any 5 digits (e.g., 12345)

**Payment Declined:**
- Card number: `4000 0000 0000 0002`

**Requires Authentication (3D Secure):**
- Card number: `4000 0025 0000 3155`

Full list: https://stripe.com/docs/testing#cards

### 6.2 Test the Flow
1. Open the app
2. Navigate to Events
3. Select a paid event
4. Fill in booking details
5. Click "Pay AED X"
6. Complete payment in Stripe sheet
7. Verify you're redirected to confirmation screen
8. Check Firestore `bookings` collection for the booking record

### 6.3 Monitor in Stripe Dashboard
- View payments: https://dashboard.stripe.com/payments
- View logs: https://dashboard.stripe.com/logs

---

## Payment Flow Diagram

```
User clicks "Pay AED X"
        ↓
Event Details Screen calls StripeService.processPayment()
        ↓
Cloud Function: createPaymentIntent
        ↓
Returns client_secret to app
        ↓
Stripe Payment Sheet presented
        ↓
User completes payment
        ↓
Payment succeeds/fails
        ↓
Create booking with payment_intent_id
        ↓
Navigate to Booking Confirmation Screen
        ↓
Webhook updates booking status (async)
```

---

## Firestore Schema

### Bookings Collection
```javascript
bookings/{bookingId}
{
  userId: string,
  eventId: string,
  eventTitle: string,
  eventDate: timestamp,
  amount: number,  // Amount paid in AED
  stripePaymentIntentId: string,  // Stripe payment intent ID
  status: string,  // 'pending', 'confirmed', 'cancelled', 'completed'
  createdAt: timestamp,
  updatedAt: timestamp
}
```

---

## Currency Configuration

Current configuration uses **AED (UAE Dirham)**.

To change currency:
1. Update `StripeService.processPayment()` in `lib/services/stripe_service.dart`
2. Update event details screen button text
3. Update Stripe account settings to accept the new currency

---

## Going to Production

### 1. Get Live API Keys
1. Complete Stripe account activation
2. Switch to "Live mode" in Stripe Dashboard
3. Get live publishable key (`pk_live_...`)
4. Get live secret key (`sk_live_...`)

### 2. Update Configuration
```dart
// In main.dart
await StripeService().initialize(
  'pk_live_YOUR_LIVE_KEY',
);
```

```bash
# In Firebase
firebase functions:config:set stripe.secret_key="sk_live_YOUR_LIVE_SECRET"
firebase deploy --only functions
```

### 3. Update Webhook
- Add new webhook endpoint for production URL
- Update webhook secret in Firebase config

---

## Troubleshooting

### Payment Sheet Not Showing
- Verify Stripe publishable key is correct
- Check Flutter console for initialization errors
- Ensure `flutter_stripe` version is compatible

### Payment Intent Creation Fails
- Check Cloud Function logs: `firebase functions:log`
- Verify secret key is set correctly
- Check event exists and is active in Firestore

### Webhook Not Receiving Events
- Verify webhook URL is correct
- Check webhook secret is set
- Test webhook in Stripe Dashboard

### Payment Succeeds but Booking Not Created
- Check EventProvider.createBooking() is called
- Verify Firestore rules allow write to bookings collection
- Check app logs for errors

---

## Security Best Practices

1. **Never expose secret keys** - Only use in Cloud Functions
2. **Always use HTTPS** - Stripe requires secure connections
3. **Validate on backend** - Don't trust client-side payment status
4. **Use webhooks** - For reliable payment status updates
5. **Handle errors gracefully** - Show user-friendly error messages
6. **Log all transactions** - For debugging and reconciliation
7. **Use test mode** - Until fully tested and ready for production

---

## Support & Resources

- **Stripe Documentation**: https://stripe.com/docs
- **Flutter Stripe Package**: https://pub.dev/packages/flutter_stripe
- **Firebase Functions**: https://firebase.google.com/docs/functions
- **Stripe Dashboard**: https://dashboard.stripe.com
- **Test Cards**: https://stripe.com/docs/testing

---

## Cost Considerations

### Stripe Fees
- **Test mode**: Free
- **Live mode**:
  - 2.9% + AED 1 per successful card charge (UAE)
  - No setup fees or monthly fees
  - Refunds: Fee is not returned

### Firebase Costs
- Cloud Functions: Pay per invocation
- Firestore: Pay per read/write
- Estimate: ~$0.40 per 1M function invocations

---

## Next Steps

1. ✅ Set up Stripe account
2. ✅ Configure API keys
3. ✅ Deploy Cloud Functions
4. ✅ Test with test cards
5. ⏳ Set up webhooks
6. ⏳ Test full booking flow
7. ⏳ Prepare for production

Good luck with your payment integration! 🚀
