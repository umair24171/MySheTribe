# MySheTribe Admin Panel - Quick Start Guide

## Setup in 5 Minutes

### Step 1: Firebase Configuration (2 minutes)

1. **Get your Firebase config from Firebase Console:**
   - Go to Project Settings → Your apps → Web app
   - Copy the config object

2. **Update `web/index.html`:**
   ```javascript
   const firebaseConfig = {
     apiKey: "YOUR_API_KEY",
     authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
     projectId: "YOUR_PROJECT_ID",
     storageBucket: "YOUR_PROJECT_ID.appspot.com",
     messagingSenderId: "YOUR_SENDER_ID",
     appId: "YOUR_APP_ID",
     measurementId: "YOUR_MEASUREMENT_ID"
   };
   ```

3. **Update `lib/main.dart`:**
   Replace the FirebaseOptions in `Firebase.initializeApp()` with your config

### Step 2: Create Admin User (2 minutes)

1. **In Firebase Console → Authentication:**
   - Click "Add user"
   - Email: admin@myshetribe.com
   - Password: Create a secure password
   - Copy the UID after creation

2. **In Firebase Console → Firestore:**
   - Go to Firestore Database
   - Create collection: `admins`
   - Add document with ID: `<paste-the-uid-you-copied>`
   - Add fields:
     - `email`: "admin@myshetribe.com"
     - `isActive`: true (boolean)
     - `createdAt`: (timestamp, use server timestamp)
     - `role`: "admin" (string)

### Step 3: Install and Run (1 minute)

```bash
cd admin_panel
flutter pub get
flutter run -d chrome
```

### Step 4: Login

1. Open the admin panel in your browser
2. Email: admin@myshetribe.com
3. Password: (the password you created)
4. Click "Sign In"

## Common Issues

### "You do not have admin privileges"
→ Make sure you created the admin document in Firestore with the correct UID

### "Firebase not initialized"
→ Check that you updated the Firebase config in both web/index.html and lib/main.dart

### "No data showing"
→ Ensure your Firestore security rules allow admin access (see README.md)

## What's Next?

- Review pending user verifications
- Manage events, tribes, and partnership offers
- Monitor user statistics on the dashboard
- Read the full README.md for advanced features

## Deploy to Production

```bash
flutter build web --release
firebase deploy --only hosting
```

That's it! You're ready to manage MySheTribe! 🎉
