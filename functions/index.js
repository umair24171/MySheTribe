const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { generateEmbedding, computeCosineSimilarity } = require('./aiMatching');

admin.initializeApp();
const db = admin.firestore();

/**
 * AI Tribe Matching Cloud Function
 * Triggered when a user profile is created or updated
 * Generates embeddings and computes tribe recommendations
 */
exports.onUserProfileWrite = functions.firestore
  .document('users/{userId}')
  .onWrite(async (change, context) => {
    try {
      const userId = context.params.userId;
      const newData = change.after.exists ? change.after.data() : null;

      // Skip if user document was deleted
      if (!newData) {
        console.log(`User ${userId} was deleted`);
        return null;
      }

      // Skip if no relevant profile data changed
      const oldData = change.before.exists ? change.before.data() : null;
      if (oldData &&
          oldData.interests === newData.interests &&
          oldData.bio === newData.bio &&
          oldData.language === newData.language &&
          oldData.city === newData.city) {
        console.log(`No relevant changes for user ${userId}`);
        return null;
      }

      console.log(`Processing AI matching for user ${userId}`);

      // Generate user embedding from bio and interests
      const userText = `${newData.bio || ''} ${(newData.interests || []).join(' ')}`.trim();

      if (!userText) {
        console.log(`No text to generate embedding for user ${userId}`);
        return null;
      }

      const userEmbedding = await generateEmbedding(userText);

      // Get all active tribes
      const tribesSnapshot = await db.collection('tribes')
        .where('isActive', '==', true)
        .get();

      if (tribesSnapshot.empty) {
        console.log('No active tribes found');
        return null;
      }

      const recommendations = [];

      // Process each tribe
      for (const tribeDoc of tribesSnapshot.docs) {
        const tribe = tribeDoc.data();
        const tribeId = tribeDoc.id;

        // Ensure tribe has embedding (generate if missing)
        let tribeEmbedding = tribe.embedding;
        if (!tribeEmbedding) {
          const tribeText = `${tribe.description || ''} ${(tribe.interests || []).join(' ')}`.trim();
          if (tribeText) {
            tribeEmbedding = await generateEmbedding(tribeText);
            // Save tribe embedding
            await db.collection('tribes').doc(tribeId).update({
              embedding: tribeEmbedding,
              updatedAt: admin.firestore.FieldValue.serverTimestamp()
            });
          }
        }

        // Calculate matching score
        const score = calculateMatchScore(newData, tribe, userEmbedding, tribeEmbedding);

        if (score > 0) {
          const matchReasons = generateMatchReasons(newData, tribe);

          recommendations.push({
            tribeId: tribeId,
            tribeName: tribe.name,
            score: score,
            matchReasons: matchReasons
          });
        }
      }

      // Sort by score and take top 10
      recommendations.sort((a, b) => b.score - a.score);
      const topRecommendations = recommendations.slice(0, 10);

      // Update user document with recommendations and embedding
      await db.collection('users').doc(userId).update({
        embedding: userEmbedding,
        recommendations: topRecommendations,
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
      });

      console.log(`Updated recommendations for user ${userId}: ${topRecommendations.length} tribes`);

      return null;
    } catch (error) {
      console.error('Error in onUserProfileWrite:', error);
      return null;
    }
  });

/**
 * Calculate match score using two-layer approach
 * Layer A: Rules-based scoring (60%)
 * Layer B: AI semantic similarity (40%)
 */
function calculateMatchScore(user, tribe, userEmbedding, tribeEmbedding) {
  // Layer A: Rules-based scoring (weights sum to 100%)
  let rulesScore = 0;

  // Interest Overlap (40%)
  const userInterests = new Set(user.interests || []);
  const tribeInterests = new Set(tribe.interests || []);
  const commonInterests = [...userInterests].filter(x => tribeInterests.has(x));
  const interestScore = userInterests.size > 0
    ? (commonInterests.length / userInterests.size) * 0.40
    : 0;
  rulesScore += interestScore;

  // Language Match (15%)
  const languageScore = user.language === tribe.language ||
                        (tribe.tags && tribe.tags.includes(user.language))
    ? 0.15 : 0;
  rulesScore += languageScore;

  // City Match (20%)
  const cityScore = user.city === tribe.city ? 0.20 : 0;
  rulesScore += cityScore;

  // Age Band Match (5%) - simplified, can be enhanced
  const ageScore = user.ageRange ? 0.05 : 0;
  rulesScore += ageScore;

  // Tribe Activity Score (20%)
  const activityScore = (tribe.activityScore || 0) * 0.20;
  rulesScore += activityScore;

  // Layer B: AI Semantic Similarity
  let aiScore = 0;
  if (userEmbedding && tribeEmbedding) {
    aiScore = computeCosineSimilarity(userEmbedding, tribeEmbedding);
  }

  // Final Score = 0.6 * Rules + 0.4 * AI Similarity
  const finalScore = (rulesScore * 0.6) + (aiScore * 0.4);

  return Math.round(finalScore * 100) / 100; // Round to 2 decimal places
}

/**
 * Generate human-readable match reasons
 */
function generateMatchReasons(user, tribe) {
  const reasons = [];

  // Check interests
  const userInterests = new Set(user.interests || []);
  const tribeInterests = new Set(tribe.interests || []);
  const commonInterests = [...userInterests].filter(x => tribeInterests.has(x));

  if (commonInterests.length > 0) {
    reasons.push(`Shared interests: ${commonInterests.slice(0, 3).join(', ')}`);
  }

  // Check city
  if (user.city === tribe.city) {
    reasons.push(`Located in ${user.city}`);
  }

  // Check language
  if (user.language === tribe.language || (tribe.tags && tribe.tags.includes(user.language))) {
    reasons.push(`Speaks ${user.language}`);
  }

  // Check activity
  if (tribe.activityScore && tribe.activityScore > 0.7) {
    reasons.push('Highly active community');
  }

  return reasons;
}

/**
 * Trigger for updating tribe embeddings when tribe is created/updated
 */
exports.onTribeWrite = functions.firestore
  .document('tribes/{tribeId}')
  .onWrite(async (change, context) => {
    try {
      const tribeId = context.params.tribeId;
      const newData = change.after.exists ? change.after.data() : null;

      if (!newData) {
        console.log(`Tribe ${tribeId} was deleted`);
        return null;
      }

      // Check if description or interests changed
      const oldData = change.before.exists ? change.before.data() : null;
      if (oldData &&
          oldData.description === newData.description &&
          JSON.stringify(oldData.interests) === JSON.stringify(newData.interests)) {
        console.log(`No relevant changes for tribe ${tribeId}`);
        return null;
      }

      // Generate tribe embedding
      const tribeText = `${newData.description || ''} ${(newData.interests || []).join(' ')}`.trim();

      if (!tribeText) {
        console.log(`No text to generate embedding for tribe ${tribeId}`);
        return null;
      }

      const embedding = await generateEmbedding(tribeText);

      // Update tribe with embedding
      await db.collection('tribes').doc(tribeId).update({
        embedding: embedding,
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
      });

      console.log(`Updated embedding for tribe ${tribeId}`);

      return null;
    } catch (error) {
      console.error('Error in onTribeWrite:', error);
      return null;
    }
  });

/**
 * HTTP Function to manually trigger tribe matching for a user
 */
exports.triggerTribeMatching = functions.https.onCall(async (data, context) => {
  // Verify user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  const userId = data.userId || context.auth.uid;

  try {
    // Get user data
    const userDoc = await db.collection('users').doc(userId).get();

    if (!userDoc.exists) {
      throw new functions.https.HttpsError('not-found', 'User not found');
    }

    // Trigger the matching by updating the user document
    await db.collection('users').doc(userId).update({
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    });

    return { success: true, message: 'Tribe matching triggered successfully' };
  } catch (error) {
    console.error('Error triggering tribe matching:', error);
    throw new functions.https.HttpsError('internal', error.message);
  }
});

// Export Stripe payment functions
const stripePayments = require('./stripePayments');
exports.createPaymentIntent = stripePayments.createPaymentIntent;
exports.confirmPaymentStatus = stripePayments.confirmPaymentStatus;
exports.refundPayment = stripePayments.refundPayment;
exports.stripeWebhook = stripePayments.stripeWebhook;
