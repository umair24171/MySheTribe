# MySheTribe - Firebase Deployment & Testing Guide

## 🎯 Current Status

All Firebase backend code is ready and committed! This guide will help you:
1. Deploy Cloud Functions for AI Tribe Matching
2. Test all app functionality
3. Verify the entire system works end-to-end

---

## 📋 Prerequisites Checklist

Before deploying, ensure you have:

- ✅ Firebase project created (project ID: `myshetribe`)
- ✅ Firebase CLI installed (already done: `npm install -g firebase-tools`)
- ✅ OpenAI API key (for AI tribe matching) OR Google Vertex AI enabled
- ✅ Firebase Blaze plan enabled (required for Cloud Functions external API calls)
- ✅ Flutter SDK installed on your development machine

---

## 🚀 Step 1: Firebase Authentication & Project Setup

### 1.1 Log in to Firebase CLI

```bash
firebase login
```

This will open a browser window for you to authenticate with your Google account.

### 1.2 Verify Project Connection

```bash
cd /path/to/MySheTribe
firebase projects:list
```

Ensure `myshetribe` appears in the list.

---

## 🔑 Step 2: Configure OpenAI API Key

The AI Tribe Matching system requires an OpenAI API key (or Google Vertex AI).

### Option A: Using OpenAI (Recommended)

1. Get your OpenAI API key from [platform.openai.com/api-keys](https://platform.openai.com/api-keys)

2. Set the environment variable:
```bash
firebase functions:config:set openai.key="YOUR_OPENAI_API_KEY_HERE"
```

### Option B: Using Google Vertex AI

1. Enable Vertex AI API in Google Cloud Console
2. Update `functions/aiMatching.js`:
   - Comment out the OpenAI import and usage
   - Uncomment the `generateEmbeddingVertexAI` function
   - Update the main `generateEmbedding` function to use Vertex AI

---

## ☁️ Step 3: Deploy Cloud Functions

### 3.1 Install Functions Dependencies (Already Done)

The dependencies are already installed, but if needed:
```bash
cd functions
npm install
cd ..
```

### 3.2 Deploy All Functions

```bash
firebase deploy --only functions
```

This will deploy:
- `onUserProfileWrite` - Triggered when user profile is updated
- `onTribeWrite` - Triggered when tribe is created/updated
- `triggerTribeMatching` - Manually trigger matching for a user

### 3.3 Verify Deployment

Check the Firebase Console → Functions section to ensure all functions are deployed successfully.

---

## 🔒 Step 4: Deploy Firestore Security Rules

```bash
firebase deploy --only firestore:rules
```

Or manually add the rules from `FIREBASE_SETUP.md` section "Security Rules" in Firebase Console → Firestore Database → Rules.

---

## 🗄️ Step 5: Deploy Storage Security Rules

```bash
firebase deploy --only storage
```

Or manually add the storage rules from `FIREBASE_SETUP.md` in Firebase Console → Storage → Rules.

---

## 📱 Step 6: Build and Test the Flutter App

### 6.1 Get Flutter Dependencies

```bash
flutter pub get
```

### 6.2 Test on Android/iOS

**For Android:**
```bash
flutter run -d android
```

**For iOS:**
```bash
flutter run -d ios
```

**For Web:**
```bash
flutter run -d chrome
```

---

## 🧪 Step 7: Test All Core Flows

### 7.1 Authentication & Onboarding Flow

1. **Sign Up**
   - Open the app → Sign Up screen
   - Enter email, password, full name, phone number, city
   - Verify user document is created in Firestore Console → users collection

2. **Email Verification**
   - Check email for verification link
   - Click link to verify
   - Log back in

3. **Profile Setup**
   - Complete profile with:
     - Languages
     - Nationality
     - Age range
     - Profession
     - Interests (select multiple)
     - Bio

4. **Verification Document Upload**
   - Upload ID/passport photo
   - Document should appear in Storage → verification_docs

5. **Verification Status**
   - Admin should approve/reject in Firestore Console
   - Update `users/{userId}` → `verificationStatus` to "approved"

### 7.2 AI Tribe Matching Flow

1. **Trigger Matching**
   - After profile setup, the Cloud Function should automatically trigger
   - Check Firebase Console → Functions → Logs to see execution

2. **Verify Recommendations**
   - Go to Firestore Console → users/{userId}
   - Check the `recommendations` field
   - Should contain top 10 tribe matches with scores and reasons

3. **Check Embeddings**
   - Verify `embedding` field exists (array of floats)
   - Check tribes also have `embedding` fields

### 7.3 Tribe Discovery

1. **View Recommended Tribes**
   - Navigate to Tribe Discovery screen
   - Should see tribes sorted by match score
   - Each should show match reasons (e.g., "Shared interests: Yoga, Networking")

2. **Browse All Tribes**
   - View all tribes by city
   - Filter by interests/tags
   - Verify tribe images load correctly

### 7.4 Events Flow

1. **Browse Events**
   - Navigate to Events screen
   - Should see upcoming events only
   - Filter by city

2. **Event Details**
   - Tap an event
   - View full details, date, location, price
   - Check attendee count

3. **RSVP to Event**
   - Click RSVP/Book
   - If paid event, should redirect to Stripe checkout
   - After payment, user should be added to `attendeeIds` array

4. **My Events**
   - View "My Events" tab
   - Should show only events user has RSVP'd to

### 7.5 Partnership Offers

1. **Browse Offers**
   - Navigate to Partnership Offers screen
   - Should see active, non-expired offers

2. **View Offer Details**
   - Tap offer
   - View discount code, terms, partner details
   - Test "Use Code" button (increments `usageCount`)

3. **Featured Offers**
   - Check featured offers on home screen
   - Verify correct filtering by city

### 7.6 Support Hub

1. **Browse Articles**
   - Navigate to Support Hub
   - View categories and articles
   - Search functionality

### 7.7 Push Notifications

1. **FCM Token**
   - Verify `fcmToken` is saved in user document after login

2. **Test Notifications**
   - Send test notification from Firebase Console → Cloud Messaging
   - App should receive and display notification

---

## 🐛 Troubleshooting

### Cloud Functions Not Triggering

1. Check Firebase Console → Functions → Logs for errors
2. Verify Firebase Blaze plan is enabled
3. Check OpenAI API key is set: `firebase functions:config:get`
4. Ensure Firestore triggers are correctly set up

### AI Matching Not Working

1. Check function logs: `firebase functions:log --only onUserProfileWrite`
2. Verify OpenAI API key is valid and has credits
3. Check user has `interests` and `bio` filled out
4. Ensure tribes exist in Firestore with `isActive: true`

### Authentication Errors

1. Check Firebase Console → Authentication is enabled
2. Verify email/password provider is enabled
3. Check security rules allow user creation

### Image Upload Failures

1. Verify Storage is enabled in Firebase Console
2. Check storage security rules are deployed
3. Ensure file size is under limits (5MB for images, 10MB for docs)

### Design/UI Issues

All margins, padding, and design elements have been preserved. If you notice any changes:
1. Check `git diff` to see what changed
2. All UI code remains untouched from the original design

---

## 📊 Monitoring & Analytics

### Firebase Console Dashboards

1. **Authentication**
   - Monitor user sign-ups, sign-ins
   - Track verification status

2. **Firestore**
   - Monitor read/write operations
   - Check data structure

3. **Cloud Functions**
   - View execution logs
   - Monitor performance and errors

4. **Storage**
   - Track file uploads
   - Monitor storage usage

5. **Analytics**
   - User engagement metrics
   - Screen views, events
   - Conversion funnels

### Recommended Monitoring

```bash
# Watch function logs in real-time
firebase functions:log --only onUserProfileWrite

# Check all function logs
firebase functions:log

# Monitor Firestore rules
firebase firestore:rules --only
```

---

## ✅ Testing Checklist

Use this checklist to ensure everything works:

- [ ] User can sign up with email/password
- [ ] Email verification email is sent
- [ ] User can log in
- [ ] Profile setup saves to Firestore
- [ ] Verification document uploads to Storage
- [ ] Admin can approve/reject verifications
- [ ] AI tribe matching generates recommendations
- [ ] User can view recommended tribes with match reasons
- [ ] User can browse all tribes
- [ ] User can view event details
- [ ] User can RSVP to free events
- [ ] Stripe checkout works for paid events
- [ ] User appears in event attendee list after RSVP
- [ ] Partnership offers display correctly
- [ ] Discount codes can be copied/used
- [ ] Support Hub articles are accessible
- [ ] Push notifications work
- [ ] Search functionality works
- [ ] All images load correctly
- [ ] No UI/design elements have changed

---

## 🎨 Design Verification

All original design elements have been preserved:
- ✅ Colors, fonts, and themes unchanged
- ✅ Margins and padding maintained
- ✅ Layout structures preserved
- ✅ Button styles and sizes same
- ✅ Icon placements unchanged
- ✅ Animation timings preserved

---

## 📝 Next Steps After Testing

1. **Production Deployment**
   - Deploy app to Google Play Store
   - Deploy app to Apple App Store
   - Set up continuous deployment

2. **Admin Panel**
   - Build web admin panel for managing:
     - User verifications
     - Tribe creation/moderation
     - Event management
     - Partnership offers
     - Analytics dashboard

3. **Group Chat Integration**
   - Integrate Stream SDK or Firebase Realtime Database
   - Enable tribe group chats
   - Direct messaging between users

4. **Payment Webhooks**
   - Set up Stripe webhooks to handle payment events
   - Automatically confirm bookings after successful payment
   - Handle refunds and cancellations

5. **Performance Optimization**
   - Implement caching for tribes and events
   - Optimize image loading with placeholders
   - Add pagination for long lists

---

## 🆘 Getting Help

If you encounter issues:

1. **Check Firebase Console Logs**
   - Functions → Logs
   - Firestore → Usage
   - Authentication → Users

2. **Review Documentation**
   - [Firebase Docs](https://firebase.google.com/docs)
   - [Flutter Firebase](https://firebase.flutter.dev)

3. **Common Issues**
   - Most issues are related to security rules or API keys
   - Check all environment variables are set
   - Ensure Firebase Blaze plan is active

---

## 📌 Important Notes

- **Never commit API keys to git** - Use environment variables
- **Test thoroughly on both platforms** - iOS and Android have different behaviors
- **Monitor costs** - Cloud Functions and AI API calls can incur costs
- **Security rules are critical** - Ensure production rules are strict
- **Backup your Firestore data** - Use Firebase export regularly

---

**Last Updated:** $(date)
**Branch:** claude/fix-userEvents-01GgtRhi1ZdQGw6a7U2qpHHS
**Status:** ✅ All backend code ready for deployment
