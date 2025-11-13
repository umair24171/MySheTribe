# MySheTribe Firebase Backend Setup Guide

This guide will help you set up the Firebase backend for MySheTribe, including Authentication, Firestore, Storage, Cloud Functions, and the AI Tribe Matching system.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Firebase Project Setup](#firebase-project-setup)
3. [Flutter Configuration](#flutter-configuration)
4. [Cloud Functions Setup](#cloud-functions-setup)
5. [Firestore Database Structure](#firestore-database-structure)
6. [Security Rules](#security-rules)
7. [Stripe Integration](#stripe-integration)
8. [Testing](#testing)

## Prerequisites

- Flutter SDK (3.8.0 or higher)
- Firebase CLI installed (`npm install -g firebase-tools`)
- Node.js 18+ for Cloud Functions
- Firebase project (create at [console.firebase.google.com](https://console.firebase.google.com))
- OpenAI API key or Google Vertex AI access (for AI tribe matching)

## Firebase Project Setup

### 1. Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click "Add project" and follow the setup wizard
3. Enable Google Analytics (recommended)

### 2. Enable Firebase Services

#### Authentication
1. Go to Authentication → Get Started
2. Enable Email/Password authentication
3. (Optional) Enable other providers: Google, Apple, etc.

#### Firestore Database
1. Go to Firestore Database → Create Database
2. Start in **Production mode**
3. Choose your location (recommend same region as your Cloud Functions)

#### Storage
1. Go to Storage → Get Started
2. Start in **Production mode**
3. Choose your location

#### Cloud Messaging (FCM)
1. Go to Cloud Messaging
2. No additional setup required for now

#### Analytics
1. Automatically enabled if selected during project creation

### 3. Add Flutter Apps

#### For Android:
1. Go to Project Settings → Add app → Android
2. Package name: `com.myshetribe.app` (or your package name from `android/app/build.gradle`)
3. Download `google-services.json`
4. Place it in `android/app/google-services.json`

#### For iOS:
1. Go to Project Settings → Add app → iOS
2. Bundle ID: `com.myshetribe.app` (or your bundle ID from `ios/Runner.xcodeproj`)
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/GoogleService-Info.plist`
5. Open Xcode and drag the file into the `Runner` folder

#### For Web:
1. Go to Project Settings → Add app → Web
2. Register the app
3. Copy the Firebase config and create `web/firebase_config.js`:

```javascript
// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";

const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "YOUR_AUTH_DOMAIN",
  projectId: "YOUR_PROJECT_ID",
  storageBucket: "YOUR_STORAGE_BUCKET",
  messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
  appId: "YOUR_APP_ID",
  measurementId: "YOUR_MEASUREMENT_ID"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
```

## Flutter Configuration

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Update Android Configuration

Edit `android/app/build.gradle`:

```gradle
android {
    defaultConfig {
        minSdkVersion 21  // Required for Firebase
        ...
    }
}
```

Edit `android/build.gradle`:

```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

Edit `android/app/build.gradle` (at the bottom):

```gradle
apply plugin: 'com.google.gms.google-services'
```

### 3. Update iOS Configuration

Edit `ios/Podfile`:

```ruby
platform :ios, '13.0'  # Minimum required for Firebase
```

Then run:

```bash
cd ios
pod install
cd ..
```

## Cloud Functions Setup

### 1. Initialize Firebase Functions

```bash
cd functions
npm install
```

### 2. Configure OpenAI API Key

For AI Tribe Matching, you need to configure the OpenAI API key:

```bash
firebase functions:config:set openai.key="YOUR_OPENAI_API_KEY"
```

**Alternative: Use Google Vertex AI**

If you prefer Google Vertex AI instead of OpenAI:

1. Enable Vertex AI API in Google Cloud Console
2. Update `functions/aiMatching.js` to use `generateEmbeddingVertexAI` function
3. Ensure your Firebase project has Vertex AI permissions

### 3. Deploy Cloud Functions

```bash
# Deploy all functions
firebase deploy --only functions

# Or deploy specific functions
firebase deploy --only functions:onUserProfileWrite,functions:onTribeWrite
```

### 4. Test Functions Locally (Optional)

```bash
# Start Firebase emulators
firebase emulators:start --only functions,firestore

# Functions will run at http://localhost:5001
```

## Firestore Database Structure

The following collections will be created automatically when you use the app:

### Collections

#### `users/{userId}`
```json
{
  "email": "user@example.com",
  "fullName": "Jane Doe",
  "phoneNumber": "+971501234567",
  "city": "Dubai",
  "country": "UAE",
  "profileImageUrl": "https://...",
  "verificationDocUrl": "https://...",
  "nationality": "British",
  "ageRange": "29 - 39 years",
  "language": "English",
  "profession": "Tech",
  "interests": ["Networking", "Wellness"],
  "bio": "Tech professional new to Dubai",
  "embedding": [...],
  "recommendations": [
    {
      "tribeId": "tribe123",
      "tribeName": "Dubai Tech Women",
      "score": 0.85,
      "matchReasons": ["Shared interests: Networking", "Located in Dubai"]
    }
  ],
  "verificationStatus": "approved",
  "fcmToken": "...",
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-01T00:00:00Z",
  "isActive": true
}
```

#### `tribes/{tribeId}`
```json
{
  "name": "Dubai Tech Women",
  "description": "A community for tech professionals",
  "imageUrl": "https://...",
  "city": "Dubai",
  "tags": ["Tech", "Networking"],
  "interests": ["Technology", "Career"],
  "memberCount": 150,
  "activityScore": 0.85,
  "embedding": [...],
  "adminId": "user123",
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-01T00:00:00Z",
  "isActive": true
}
```

#### `events/{eventId}`
```json
{
  "title": "Tech Networking Evening",
  "description": "...",
  "imageUrl": "https://...",
  "location": "Dubai Marina",
  "city": "Dubai",
  "eventDate": "2024-02-01T18:00:00Z",
  "eventEndDate": "2024-02-01T21:00:00Z",
  "price": 50.00,
  "stripeCheckoutUrl": "https://...",
  "maxAttendees": 50,
  "attendeeIds": ["user1", "user2"],
  "organizerId": "user123",
  "tribeId": "tribe123",
  "category": "networking",
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-01T00:00:00Z",
  "isActive": true
}
```

#### `partnership_offers/{offerId}`
```json
{
  "title": "20% off at Spa Name",
  "description": "...",
  "imageUrl": "https://...",
  "partnerName": "Spa Name",
  "partnerLogo": "https://...",
  "discountCode": "MYSHETRIBE20",
  "discountPercentage": 20.0,
  "category": "Wellness",
  "termsAndConditions": "...",
  "expiryDate": "2024-12-31T23:59:59Z",
  "websiteUrl": "https://...",
  "contactEmail": "partner@example.com",
  "cities": ["Dubai", "Abu Dhabi"],
  "usageCount": 42,
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-01T00:00:00Z",
  "isActive": true,
  "isFeatured": true
}
```

#### `bookings/{bookingId}`
```json
{
  "userId": "user123",
  "eventId": "event456",
  "eventTitle": "Tech Networking Evening",
  "eventDate": "2024-02-01T18:00:00Z",
  "amount": 50.00,
  "stripePaymentIntentId": "pi_...",
  "status": "confirmed",
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-01T00:00:00Z"
}
```

## Security Rules

### Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Helper functions
    function isAuthenticated() {
      return request.auth != null;
    }

    function isOwner(userId) {
      return isAuthenticated() && request.auth.uid == userId;
    }

    // Users collection
    match /users/{userId} {
      allow read: if isAuthenticated();
      allow create: if isOwner(userId);
      allow update: if isOwner(userId);
      allow delete: if isOwner(userId);
    }

    // Tribes collection
    match /tribes/{tribeId} {
      allow read: if isAuthenticated();
      allow create: if isAuthenticated();
      allow update: if isAuthenticated() && resource.data.adminId == request.auth.uid;
      allow delete: if isAuthenticated() && resource.data.adminId == request.auth.uid;
    }

    // Events collection
    match /events/{eventId} {
      allow read: if isAuthenticated();
      allow create: if isAuthenticated();
      allow update: if isAuthenticated() && resource.data.organizerId == request.auth.uid;
      allow delete: if isAuthenticated() && resource.data.organizerId == request.auth.uid;
    }

    // Partnership offers (read-only for users)
    match /partnership_offers/{offerId} {
      allow read: if isAuthenticated();
      allow write: if false; // Only via Cloud Functions or Admin SDK
    }

    // Bookings
    match /bookings/{bookingId} {
      allow read: if isAuthenticated() && resource.data.userId == request.auth.uid;
      allow create: if isAuthenticated() && request.resource.data.userId == request.auth.uid;
      allow update: if isOwner(resource.data.userId);
      allow delete: if isOwner(resource.data.userId);
    }
  }
}
```

Deploy security rules:

```bash
firebase deploy --only firestore:rules
```

### Storage Security Rules

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {

    function isAuthenticated() {
      return request.auth != null;
    }

    function isOwner(userId) {
      return request.auth.uid == userId;
    }

    // Profile images
    match /profile_images/{userId}/{fileName} {
      allow read: if isAuthenticated();
      allow write: if isOwner(userId) && request.resource.size < 5 * 1024 * 1024; // 5MB
    }

    // Verification documents
    match /verification_docs/{userId}/{fileName} {
      allow read: if isOwner(userId);
      allow write: if isOwner(userId) && request.resource.size < 10 * 1024 * 1024; // 10MB
    }

    // Event images
    match /event_images/{eventId}/{fileName} {
      allow read: if isAuthenticated();
      allow write: if isAuthenticated() && request.resource.size < 5 * 1024 * 1024;
    }

    // Tribe images
    match /tribe_images/{tribeId}/{fileName} {
      allow read: if isAuthenticated();
      allow write: if isAuthenticated() && request.resource.size < 5 * 1024 * 1024;
    }
  }
}
```

Deploy storage rules:

```bash
firebase deploy --only storage
```

## Stripe Integration

### 1. Set up Stripe Account

1. Create account at [stripe.com](https://stripe.com)
2. Get your API keys (Dashboard → Developers → API keys)

### 2. Configure Stripe in Flutter

Add your Stripe publishable key to your app. Create `lib/config/stripe_config.dart`:

```dart
class StripeConfig {
  static const String publishableKey = 'pk_test_...'; // Your publishable key
  static const String merchantDisplayName = 'MySheTribe';
}
```

### 3. Initialize Stripe in main.dart

Already configured in the updated `main.dart`

### 4. Create Stripe Checkout Sessions (Backend)

You'll need to create a Cloud Function or backend endpoint to create Stripe checkout sessions:

```javascript
// functions/index.js
const stripe = require('stripe')('sk_test_...'); // Your secret key

exports.createStripeCheckout = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  const { eventId, amount, eventTitle } = data;

  const session = await stripe.checkout.sessions.create({
    payment_method_types: ['card'],
    line_items: [
      {
        price_data: {
          currency: 'aed',
          product_data: {
            name: eventTitle,
          },
          unit_amount: amount * 100, // Stripe expects amount in cents
        },
        quantity: 1,
      },
    ],
    mode: 'payment',
    success_url: 'https://yourdomain.com/success?session_id={CHECKOUT_SESSION_ID}',
    cancel_url: 'https://yourdomain.com/cancel',
    metadata: {
      eventId: eventId,
      userId: context.auth.uid,
    },
  });

  return { sessionId: session.id, url: session.url };
});
```

## Testing

### 1. Test Authentication

```bash
# Run the app
flutter run

# Try signing up with a test email
# Check Firebase Console → Authentication to verify user creation
```

### 2. Test Firestore

1. Sign up a user
2. Check Firebase Console → Firestore
3. Verify user document is created

### 3. Test Cloud Functions

1. Update a user profile with interests and bio
2. Check Firebase Console → Firestore → users/{userId}
3. Verify `embedding` and `recommendations` fields are populated

### 4. Monitor Functions

```bash
# View function logs
firebase functions:log

# Or in Firebase Console → Functions
```

### 5. Test AI Matching

1. Create some tribes in Firestore manually (or via Admin panel)
2. Update user profile with interests matching tribes
3. Wait for Cloud Function to trigger (or trigger manually)
4. Check user document for recommendations

## Troubleshooting

### Common Issues

1. **"Null check operator used on a null value"**
   - Ensure Firebase is initialized before running the app
   - Check that google-services.json / GoogleService-Info.plist are in place

2. **Cloud Functions not triggering**
   - Check function logs: `firebase functions:log`
   - Verify functions are deployed: `firebase functions:list`
   - Check billing is enabled (Blaze plan required for external API calls)

3. **AI Matching not working**
   - Verify OpenAI API key is configured
   - Check function logs for errors
   - Ensure billing is enabled (required for OpenAI API calls)

4. **Permission denied errors**
   - Review Firestore security rules
   - Ensure user is authenticated
   - Check that rules are deployed

## Next Steps

1. **Admin Panel**: Create admin interface for managing users, tribes, events, and partnership offers
2. **Push Notifications**: Implement FCM for in-app notifications
3. **Group Chat**: Integrate Stream SDK or similar for tribe chat functionality
4. **Testing**: Write integration tests for Firebase services
5. **Monitoring**: Set up Firebase Performance Monitoring and Crashlytics

## Support

For issues or questions:
- Check Firebase documentation: [firebase.google.com/docs](https://firebase.google.com/docs)
- Flutter Firebase: [firebase.flutter.dev](https://firebase.flutter.dev)
- GitHub Issues: [Create an issue](https://github.com/yourrepo/issues)

---

**Note**: Remember to replace all placeholder values (API keys, package names, etc.) with your actual project values. Never commit sensitive keys to version control!
