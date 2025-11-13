# MySheTribe Admin Panel

A comprehensive Flutter web-based administration panel for managing the MySheTribe platform.

## Features

### 1. Dashboard Overview
- Real-time statistics for users, events, tribes, and partnership offers
- Visual representation of key metrics
- Quick access to all management modules

### 2. User Management
- **Pending Verifications Queue**
  - View all users awaiting verification
  - Display user profile images and verification documents
  - Approve or reject verifications with notes/reasons
  - Full-screen image viewer for verification documents

- **All Users Management**
  - Comprehensive user list with search and filter capabilities
  - View detailed user information
  - Activate/deactivate user accounts
  - Delete users
  - Filter by verification status

### 3. Content Management
- **Events Management**
  - View all events with details (date, location, attendees, price)
  - Delete events
  - Track event attendance and capacity

- **Tribes Management**
  - Manage all tribes/communities
  - Monitor membership counts and activity scores
  - View tribe interests and tags
  - Delete tribes

- **Partnership Offers Management**
  - Manage partnership offers and discounts
  - Track discount codes and usage statistics
  - Monitor expiry dates
  - Delete partnership offers

### 4. Authentication & Security
- Admin-only access with email/password authentication
- Firebase authentication integration
- Admin role verification through Firestore

## Technology Stack

- **Framework**: Flutter for Web
- **State Management**: Provider
- **Backend**: Firebase (Firestore, Authentication, Storage)
- **UI Components**: Material Design
- **Typography**: Google Fonts (Poppins)
- **Image Caching**: cached_network_image
- **Data Visualization**: fl_chart

## Setup Instructions

### Prerequisites

1. Flutter SDK (3.8.0 or higher)
2. Firebase project with web app configured
3. Node.js and npm (for Firebase CLI)
4. Admin credentials configured in Firestore

### Installation

1. **Navigate to admin panel directory**
   ```bash
   cd admin_panel
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**

   Update the Firebase configuration in two places:

   a. `web/index.html` - Update the `firebaseConfig` object:
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

   b. `lib/main.dart` - Update the `FirebaseOptions` in the `Firebase.initializeApp` call

4. **Create Admin Users in Firestore**

   In your Firebase Console, manually create admin documents:

   Collection: `admins`
   Document ID: `<admin-user-uid>` (Firebase Auth UID)
   Fields:
   ```json
   {
     "email": "admin@myshetribe.com",
     "isActive": true,
     "createdAt": <current timestamp>,
     "role": "admin"
   }
   ```

5. **Run in Development**
   ```bash
   flutter run -d chrome
   ```

### Building for Production

1. **Build web assets**
   ```bash
   flutter build web --release
   ```

2. **Deploy to Firebase Hosting**

   Initialize Firebase Hosting (if not already done):
   ```bash
   firebase init hosting
   ```

   Select the `build/web` folder when prompted for the public directory.

   Deploy:
   ```bash
   firebase deploy --only hosting
   ```

## Project Structure

```
admin_panel/
├── lib/
│   ├── main.dart                          # App entry point
│   ├── models/                            # Data models
│   │   ├── user_model.dart
│   │   ├── event_model.dart
│   │   ├── tribe_model.dart
│   │   └── partnership_offer_model.dart
│   ├── providers/                         # State management
│   │   ├── admin_auth_provider.dart
│   │   ├── user_management_provider.dart
│   │   └── content_management_provider.dart
│   └── screens/                           # UI screens
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
│   ├── index.html                         # Web entry point
│   └── manifest.json                      # PWA manifest
└── pubspec.yaml                           # Dependencies
```

## Usage Guide

### Login
1. Navigate to the admin panel URL
2. Enter your admin email and password
3. Click "Sign In"
4. Only users with admin privileges in Firestore can access the panel

### User Verification
1. Navigate to "Verifications" in the sidebar
2. Review pending user verification requests
3. View profile images and verification documents
4. Click "Approve" to approve or "Reject" to reject with a reason
5. Approved users receive "approved" status
6. Rejected users receive "rejected" status with the reason you provide

### Managing Users
1. Navigate to "All Users" in the sidebar
2. Use the search bar to find specific users
3. Filter by verification status using the dropdown
4. Toggle user active/inactive status
5. View detailed user information
6. Delete users if necessary

### Managing Content

**Events:**
1. Navigate to "Events" in the sidebar
2. View all events with attendee counts and dates
3. Click info icon to view full event details
4. Delete events using the delete icon

**Tribes:**
1. Navigate to "Tribes" in the sidebar
2. Monitor member counts and activity scores
3. View tribe interests and details
4. Delete tribes if necessary

**Partnership Offers:**
1. Navigate to "Partnerships" in the sidebar
2. Track discount codes and usage statistics
3. Monitor expiry dates (expired offers show in red)
4. View and delete partnership offers

### Dashboard Statistics
- View real-time counts for:
  - Total users
  - Pending verifications
  - Approved/rejected users
  - Total events and active events
  - Total tribes
  - Partnership offers

## Security

### Firestore Security Rules

The admin panel requires specific security rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Admin collection - only admins can read their own doc
    match /admins/{adminId} {
      allow read: if request.auth != null && request.auth.uid == adminId;
      allow write: if false; // Only via Admin SDK
    }

    // Users collection - admins can read all, update verification status
    match /users/{userId} {
      allow read: if request.auth != null && exists(/databases/$(database)/documents/admins/$(request.auth.uid));
      allow update: if request.auth != null && exists(/databases/$(database)/documents/admins/$(request.auth.uid));
      allow delete: if request.auth != null && exists(/databases/$(database)/documents/admins/$(request.auth.uid));
    }

    // Events, Tribes, Partnerships - admins have full access
    match /events/{eventId} {
      allow read, write: if request.auth != null && exists(/databases/$(database)/documents/admins/$(request.auth.uid));
    }

    match /tribes/{tribeId} {
      allow read, write: if request.auth != null && exists(/databases/$(database)/documents/admins/$(request.auth.uid));
    }

    match /partnership_offers/{offerId} {
      allow read, write: if request.auth != null && exists(/databases/$(database)/documents/admins/$(request.auth.uid));
    }
  }
}
```

### Creating Admin Users

**Method 1: Using Firebase Console**
1. Create a user in Firebase Authentication
2. Copy the user's UID
3. In Firestore, create a document in the `admins` collection with the UID as the document ID
4. Set `isActive: true`

**Method 2: Using Admin SDK (Recommended for production)**
```javascript
// Cloud Function to create admin
exports.createAdmin = functions.https.onCall(async (data, context) => {
  // Verify the requester is a super admin
  const { email } = data;

  const userRecord = await admin.auth().createUser({
    email: email,
    password: generateSecurePassword(),
  });

  await admin.firestore().collection('admins').doc(userRecord.uid).set({
    email: email,
    isActive: true,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    role: 'admin'
  });

  return { success: true, uid: userRecord.uid };
});
```

## Troubleshooting

### Login Issues
- **Error: "You do not have admin privileges"**
  - Ensure the user has a document in the `admins` collection
  - Verify `isActive` is set to `true`
  - Check Firestore security rules

### Data Not Loading
- **Users/Events/Tribes not showing**
  - Check Firebase console for data
  - Verify Firestore security rules allow admin access
  - Check browser console for errors
  - Ensure internet connectivity

### Build Errors
- **Firebase configuration errors**
  - Verify Firebase config in `web/index.html` and `lib/main.dart`
  - Ensure all Firebase services are enabled

- **Package dependency errors**
  - Run `flutter clean`
  - Run `flutter pub get`
  - Ensure Flutter SDK is up to date

## Future Enhancements

Planned features for future releases:

1. **Analytics Dashboard**
   - User growth charts
   - Event attendance trends
   - Tribe membership analytics
   - Partnership offer redemption stats

2. **Create/Edit Forms**
   - Create new events directly from admin panel
   - Create new tribes
   - Create new partnership offers
   - Edit existing content

3. **Notification Management**
   - Send push notifications to users
   - Send targeted notifications to specific user groups
   - Schedule notifications

4. **Advanced Filters**
   - Filter events by date range, category
   - Filter tribes by city, activity score
   - Export data to CSV/Excel

5. **Audit Logs**
   - Track all admin actions
   - View history of verifications
   - Monitor content changes

6. **Role-Based Access Control**
   - Multiple admin roles (Super Admin, Content Manager, Verifier)
   - Granular permissions

## Support

For issues or questions:
- Check Firebase logs
- Review Firestore security rules
- Verify admin user configuration
- Check browser console for errors

## License

This admin panel is part of the MySheTribe platform and follows the same license as the main application.

---

**Version**: 1.0.0
**Last Updated**: 2024
**Maintained by**: MySheTribe Development Team
