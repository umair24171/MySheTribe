# MySheTribe Admin Panel - Complete Implementation

## Overview

The MySheTribe Admin Panel is now **fully implemented** as a separate Flutter web application located in the `admin_panel/` directory.

## What's Included

### ✅ Complete Admin Panel Implementation

The admin panel includes all essential features for managing the MySheTribe platform:

1. **Dashboard**
   - Real-time statistics (users, events, tribes, partnerships)
   - Visual cards showing key metrics
   - Quick navigation to all management modules

2. **User Verification System**
   - Pending verifications queue with image preview
   - Full-screen verification document viewer
   - Approve/Reject functionality with notes/reasons
   - Automatic status updates in Firestore

3. **User Management**
   - Comprehensive user list with search and filtering
   - View detailed user information
   - Activate/deactivate user accounts
   - Delete users
   - Filter by verification status

4. **Content Management**
   - **Events Management**: View, delete events with attendance tracking
   - **Tribes Management**: Manage communities with member counts and activity scores
   - **Partnership Offers Management**: Track discount codes, usage, and expiry dates

5. **Authentication & Security**
   - Admin-only access with Firebase Authentication
   - Role verification through Firestore `admins` collection
   - Secure session management

## Directory Structure

```
admin_panel/
├── lib/
│   ├── main.dart                                    # Application entry point
│   ├── models/                                      # Data models
│   │   ├── user_model.dart
│   │   ├── event_model.dart
│   │   ├── tribe_model.dart
│   │   └── partnership_offer_model.dart
│   ├── providers/                                   # State management
│   │   ├── admin_auth_provider.dart
│   │   ├── user_management_provider.dart
│   │   └── content_management_provider.dart
│   └── screens/                                     # UI screens
│       ├── auth/
│       │   └── admin_login_screen.dart
│       ├── dashboard/
│       │   └── dashboard_screen.dart
│       ├── users/
│       │   ├── user_verification_screen.dart
│       │   └── all_users_screen.dart
│       └── content/
│           ├── events_management_screen.dart
│           ├── tribes_management_screen.dart
│           └── partnerships_management_screen.dart
├── web/
│   ├── index.html                                   # Firebase config here
│   └── manifest.json
├── pubspec.yaml                                     # Dependencies
├── README.md                                        # Full documentation
├── QUICK_START.md                                   # 5-minute setup guide
└── .gitignore
```

## Quick Start

### 1. Configure Firebase (2 minutes)

Update Firebase configuration in two files:

**a. `admin_panel/web/index.html`** (line ~47):
```javascript
const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "YOUR_AUTH_DOMAIN",
  projectId: "YOUR_PROJECT_ID",
  storageBucket: "YOUR_STORAGE_BUCKET",
  messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
  appId: "YOUR_APP_ID",
  measurementId: "YOUR_MEASUREMENT_ID"
};
```

**b. `admin_panel/lib/main.dart`** (line ~13):
```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_AUTH_DOMAIN",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_STORAGE_BUCKET",
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
    appId: "YOUR_APP_ID",
    measurementId: "YOUR_MEASUREMENT_ID",
  ),
);
```

### 2. Create Admin User in Firestore (2 minutes)

**Step 1:** Create a user in Firebase Authentication
- Go to Firebase Console → Authentication
- Click "Add user"
- Email: `admin@myshetribe.com`
- Password: Create a secure password
- **Copy the UID** after creation

**Step 2:** Create admin document in Firestore
- Go to Firebase Console → Firestore Database
- Create collection: `admins`
- Add document with ID: `<paste-the-uid>`
- Add fields:
  ```
  email: "admin@myshetribe.com" (string)
  isActive: true (boolean)
  role: "admin" (string)
  createdAt: <server timestamp>
  ```

### 3. Install Dependencies and Run (1 minute)

```bash
cd admin_panel
flutter pub get
flutter run -d chrome
```

### 4. Login

Navigate to `http://localhost:PORT` (or the URL shown in terminal)
- Email: admin@myshetribe.com
- Password: (your admin password)
- Click "Sign In"

## Features Breakdown

### Dashboard Home
- **Total Users**: All registered users count
- **Pending Verifications**: Users awaiting approval
- **Approved Users**: Successfully verified users
- **Rejected Users**: Declined verifications
- **Total Events**: All events count
- **Active Events**: Currently active events
- **Total Tribes**: All communities count
- **Partnership Offers**: All partnership offers count

### User Verification
- View all pending and under-review users
- Display user information (name, email, phone, city, nationality, registration date)
- Show profile images
- Show verification documents (selfies)
- Full-screen image viewer
- **Approve**: Mark user as verified with optional notes
- **Reject**: Mark user as rejected with mandatory reason
- Automatic Firestore updates

### All Users Management
- Search users by name or email
- Filter by verification status (Pending, Under Review, Approved, Rejected)
- View complete user details in dialog
- Toggle user active/inactive status
- Delete users with confirmation
- Data table with pagination support

### Events Management
- View all events in data table
- Display: Title, City, Event Date, Category, Price, Attendees, Active status
- View full event details
- Delete events with confirmation
- Track attendance (attendees/max capacity)

### Tribes Management
- View all tribes in data table
- Display: Name, City, Members, Activity Score, Interests, Active status
- View full tribe details
- Delete tribes with confirmation
- Monitor member counts and activity

### Partnerships Management
- View all partnership offers in data table
- Display: Title, Partner, Category, Discount, Code, Usage, Expiry, Active status
- View full offer details
- Delete offers with confirmation
- Track usage statistics
- Highlight expired offers in red

## Security Implementation

### Firestore Security Rules

Add these rules to your Firestore security rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Helper function to check if user is admin
    function isAdmin() {
      return request.auth != null &&
             exists(/databases/$(database)/documents/admins/$(request.auth.uid)) &&
             get(/databases/$(database)/documents/admins/$(request.auth.uid)).data.isActive == true;
    }

    // Admin collection
    match /admins/{adminId} {
      allow read: if request.auth != null && request.auth.uid == adminId;
      allow write: if false; // Only via Admin SDK
    }

    // Users collection - admins can manage
    match /users/{userId} {
      allow read, update, delete: if isAdmin();
      allow create: if request.auth != null; // Anyone can create during signup
    }

    // Events collection - admins can manage
    match /events/{eventId} {
      allow read: if request.auth != null;
      allow write: if isAdmin();
    }

    // Tribes collection - admins can manage
    match /tribes/{tribeId} {
      allow read: if request.auth != null;
      allow write: if isAdmin();
    }

    // Partnership offers - admins can manage
    match /partnership_offers/{offerId} {
      allow read: if request.auth != null;
      allow write: if isAdmin();
    }
  }
}
```

Deploy rules:
```bash
firebase deploy --only firestore:rules
```

## Deployment to Production

### Build for Production

```bash
cd admin_panel
flutter build web --release
```

### Deploy to Firebase Hosting

1. **Initialize Firebase Hosting** (if not already done):
   ```bash
   firebase init hosting
   ```
   - Select your Firebase project
   - Public directory: `build/web`
   - Configure as single-page app: Yes
   - Set up automatic builds: No

2. **Deploy**:
   ```bash
   firebase deploy --only hosting
   ```

3. **Access your admin panel**:
   ```
   https://YOUR_PROJECT_ID.web.app
   ```

### Alternative: Deploy to Subdomain

To deploy admin panel to a subdomain (e.g., admin.myshetribe.com):

1. Update `firebase.json`:
   ```json
   {
     "hosting": [
       {
         "target": "admin",
         "public": "admin_panel/build/web",
         "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
         "rewrites": [
           {
             "source": "**",
             "destination": "/index.html"
           }
         ]
       }
     ]
   }
   ```

2. Set up hosting target:
   ```bash
   firebase target:apply hosting admin YOUR_PROJECT_ID
   ```

3. Deploy:
   ```bash
   firebase deploy --only hosting:admin
   ```

## Technology Stack

- **Frontend Framework**: Flutter for Web
- **State Management**: Provider pattern
- **Backend**: Firebase (Authentication, Firestore, Storage)
- **UI Design**: Material Design 3
- **Typography**: Google Fonts (Poppins)
- **Image Handling**: cached_network_image
- **Data Visualization**: fl_chart (ready for analytics)
- **Date Formatting**: intl package

## Dependencies

All dependencies are already configured in `admin_panel/pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Firebase
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  cloud_firestore: ^5.4.4
  firebase_storage: ^12.3.4
  firebase_analytics: ^11.3.3

  # State Management
  provider: ^6.1.2

  # UI
  google_fonts: ^6.3.2
  cached_network_image: ^3.4.1
  flutter_spinkit: ^5.2.1

  # Utilities
  intl: ^0.19.0
  url_launcher: ^6.3.1
  image_picker: ^1.1.2
  file_picker: ^8.1.2

  # Charts (for future analytics)
  fl_chart: ^0.69.0
```

## Future Enhancements (Planned)

The following features are planned for future releases:

1. **Create/Edit Forms**
   - Create new events from admin panel
   - Create new tribes
   - Create new partnership offers
   - Edit existing content inline

2. **Advanced Analytics**
   - User growth charts
   - Event attendance trends
   - Tribe membership analytics
   - Partnership redemption statistics

3. **Bulk Operations**
   - Bulk approve/reject verifications
   - Bulk delete/deactivate users
   - Export data to CSV

4. **Notification Management**
   - Send push notifications to users
   - Targeted notifications by tribe/city
   - Scheduled notifications

5. **Role-Based Access**
   - Super Admin, Content Manager, Verifier roles
   - Granular permissions per role
   - Audit logs

6. **Advanced Filtering**
   - Date range filters for events
   - City-based filters
   - Multi-criteria search

## Troubleshooting

### Issue: "You do not have admin privileges"
**Solution**:
- Verify the admin document exists in Firestore `admins` collection
- Ensure the document ID matches the Firebase Auth UID
- Check that `isActive` field is set to `true`

### Issue: Data not loading
**Solution**:
- Check Firestore security rules (see Security Implementation section)
- Verify Firebase is initialized correctly
- Check browser console for errors
- Ensure you have internet connectivity

### Issue: Images not displaying
**Solution**:
- Verify Firebase Storage CORS configuration
- Check that image URLs are accessible
- Ensure Storage security rules allow admin read access

### Issue: Build errors
**Solution**:
```bash
flutter clean
flutter pub get
flutter pub upgrade
flutter run -d chrome
```

## Support & Documentation

- **Full Documentation**: `admin_panel/README.md`
- **Quick Start Guide**: `admin_panel/QUICK_START.md`
- **Main App Integration**: `FIREBASE_SETUP.md`
- **Screen Integration**: `SCREEN_INTEGRATION_GUIDE.md`

## Summary

The admin panel is **production-ready** with:
- ✅ Complete authentication system
- ✅ User verification workflow
- ✅ Comprehensive user management
- ✅ Content management for events, tribes, and partnerships
- ✅ Real-time dashboard statistics
- ✅ Security rules implementation
- ✅ Full documentation
- ✅ Deployment instructions

You can now:
1. Configure Firebase credentials
2. Create admin users
3. Run locally for testing
4. Deploy to production

The admin panel works seamlessly with the main MySheTribe Flutter mobile app and shares the same Firebase backend.

---

**Status**: ✅ Complete and Ready for Deployment
**Version**: 1.0.0
**Last Updated**: 2024
