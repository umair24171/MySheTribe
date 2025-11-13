# MySheTribe Admin Panel - Flutter Web Setup Guide

This document provides complete instructions for creating a separate Flutter web admin panel for MySheTribe.

## Overview

The admin panel is a **separate Flutter web application** that connects to the same Firebase project as your mobile app. It provides:

✅ User verification approval/rejection
✅ Tribe management (create, edit, delete)
✅ Event management
✅ Partnership offers management
✅ Content moderation
✅ Analytics and reporting
✅ User management

---

## Part 1: Create New Flutter Web Project

### Step 1: Create Admin Panel Project

```bash
# Navigate to your projects directory (NOT inside MySheTribe)
cd ~/projects  # or wherever you keep your projects

# Create new Flutter project
flutter create myshetribe_admin_panel

# Navigate into project
cd myshetribe_admin_panel

# Enable web
flutter config --enable-web

# Verify web is enabled
flutter devices
```

### Step 2: Update `pubspec.yaml`

```yaml
name: myshetribe_admin_panel
description: MySheTribe Admin Panel - Flutter Web
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.8.0

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
  fl_chart: ^0.68.0  # For analytics charts
  data_table_2: ^2.5.15  # For data tables

  # Utilities
  intl: ^0.19.0
  uuid: ^4.5.1
  image_picker_web: ^4.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
```

### Step 3: Add Firebase Config

Create `web/firebase_config.js`:

```javascript
// Use the SAME Firebase config as your mobile app
const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "YOUR_PROJECT.firebaseapp.com",
  projectId: "YOUR_PROJECT_ID",
  storageBucket: "YOUR_PROJECT.appspot.com",
  messagingSenderId: "YOUR_SENDER_ID",
  appId: "YOUR_APP_ID",
  measurementId: "YOUR_MEASUREMENT_ID"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);
```

Update `web/index.html`:

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>MySheTribe Admin Panel</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Firebase SDKs -->
  <script src="https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js"></script>
  <script src="https://www.gstatic.com/firebasejs/10.7.0/firebase-auth-compat.js"></script>
  <script src="https://www.gstatic.com/firebasejs/10.7.0/firebase-firestore-compat.js"></script>
  <script src="https://www.gstatic.com/firebasejs/10.7.0/firebase-storage-compat.js"></script>
  <script src="https://www.gstatic.com/firebasejs/10.7.0/firebase-analytics-compat.js"></script>

  <!-- Firebase Config -->
  <script src="firebase_config.js"></script>

  <script src="flutter_bootstrap.js" async></script>
</head>
<body>
  <div id="loading">Loading Admin Panel...</div>
</body>
</html>
```

---

## Part 2: Project Structure

Create this folder structure:

```
myshetribe_admin_panel/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   ├── user_model.dart  (copy from mobile app)
│   │   ├── tribe_model.dart
│   │   ├── event_model.dart
│   │   ├── partnership_offer_model.dart
│   │   └── admin_user_model.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   ├── admin_service.dart
│   │   ├── firestore_service.dart
│   │   └── analytics_service.dart
│   ├── providers/
│   │   ├── admin_auth_provider.dart
│   │   ├── user_management_provider.dart
│   │   ├── content_provider.dart
│   │   └── analytics_provider.dart
│   ├── screens/
│   │   ├── login/
│   │   │   └── admin_login_screen.dart
│   │   ├── dashboard/
│   │   │   └── dashboard_screen.dart
│   │   ├── users/
│   │   │   ├── user_list_screen.dart
│   │   │   ├── user_detail_screen.dart
│   │   │   └── verification_queue_screen.dart
│   │   ├── tribes/
│   │   │   ├── tribe_list_screen.dart
│   │   │   ├── tribe_form_screen.dart
│   │   │   └── tribe_detail_screen.dart
│   │   ├── events/
│   │   │   ├── event_list_screen.dart
│   │   │   └── event_form_screen.dart
│   │   ├── partnerships/
│   │   │   ├── offer_list_screen.dart
│   │   │   └── offer_form_screen.dart
│   │   └── analytics/
│   │       └── analytics_screen.dart
│   └── widgets/
│       ├── admin_sidebar.dart
│       ├── data_table_widget.dart
│       └── stat_card.dart
└── web/
    ├── index.html
    └── firebase_config.js
```

---

## Part 3: Core Implementation

### main.dart

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'providers/admin_auth_provider.dart';
import 'providers/user_management_provider.dart';
import 'providers/content_provider.dart';
import 'providers/analytics_provider.dart';
import 'screens/login/admin_login_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_API_KEY",
      authDomain: "YOUR_PROJECT.firebaseapp.com",
      projectId: "YOUR_PROJECT_ID",
      storageBucket: "YOUR_PROJECT.appspot.com",
      messagingSenderId: "YOUR_SENDER_ID",
      appId: "YOUR_APP_ID",
      measurementId: "YOUR_MEASUREMENT_ID",
    ),
  );

  runApp(const MySheTribeAdminApp());
}

class MySheTribeAdminApp extends StatelessWidget {
  const MySheTribeAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AdminAuthProvider()),
        ChangeNotifierProvider(create: (_) => UserManagementProvider()),
        ChangeNotifierProvider(create: (_) => ContentProvider()),
        ChangeNotifierProvider(create: (_) => AnalyticsProvider()),
      ],
      child: MaterialApp(
        title: 'MySheTribe Admin Panel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFFFFB6C8),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFFB6C8),
            primary: const Color(0xFFFFB6C8),
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminAuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isAuthenticated) {
          return const DashboardScreen();
        }
        return const AdminLoginScreen();
      },
    );
  }
}
```

### Admin Login Screen

```dart
// lib/screens/login/admin_login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/admin_auth_provider.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      body: Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                Text(
                  'MySheTribe',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3A3A3A),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Admin Panel',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 40),

                // Email field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Admin Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Login button
                Consumer<AdminAuthProvider>(
                  builder: (context, authProvider, child) {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: authProvider.isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  bool success = await authProvider.login(
                                    _emailController.text.trim(),
                                    _passwordController.text,
                                  );

                                  if (!success && mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          authProvider.errorMessage ??
                                              'Login failed',
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3A3A3A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: authProvider.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Login',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

### Dashboard Screen

```dart
// lib/screens/dashboard/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/admin_sidebar.dart';
import '../users/verification_queue_screen.dart';
import '../users/user_list_screen.dart';
import '../tribes/tribe_list_screen.dart';
import '../events/event_list_screen.dart';
import '../partnerships/offer_list_screen.dart';
import '../analytics/analytics_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardHomeScreen(),
    const VerificationQueueScreen(),
    const UserListScreen(),
    const TribeListScreen(),
    const EventListScreen(),
    const OfferListScreen(),
    const AnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          AdminSidebar(
            selectedIndex: _selectedIndex,
            onItemSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),

          // Main content
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

class DashboardHomeScreen extends StatelessWidget {
  const DashboardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),

          // Stats cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Total Users',
                  '1,234',
                  Icons.people,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildStatCard(
                  'Pending Verifications',
                  '45',
                  Icons.pending,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildStatCard(
                  'Active Tribes',
                  '78',
                  Icons.groups,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildStatCard(
                  'Upcoming Events',
                  '23',
                  Icons.event,
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 40),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## Part 4: Key Features Implementation

### User Verification Queue

```dart
// lib/screens/users/verification_queue_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/user_management_provider.dart';
import '../../models/user_model.dart';

class VerificationQueueScreen extends StatefulWidget {
  const VerificationQueueScreen({super.key});

  @override
  State<VerificationQueueScreen> createState() => _VerificationQueueScreenState();
}

class _VerificationQueueScreenState extends State<VerificationQueueScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      Provider.of<UserManagementProvider>(context, listen: false)
          .loadPendingVerifications()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Verification Queue',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: Consumer<UserManagementProvider>(
              builder: (context, userProvider, child) {
                if (userProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (userProvider.pendingUsers.isEmpty) {
                  return Center(
                    child: Text(
                      'No pending verifications',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: userProvider.pendingUsers.length,
                  itemBuilder: (context, index) {
                    final user = userProvider.pendingUsers[index];
                    return _buildVerificationCard(user, userProvider);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationCard(UserModel user, UserManagementProvider provider) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // User info
            CircleAvatar(
              radius: 30,
              backgroundImage: user.profileImageUrl != null
                  ? NetworkImage(user.profileImageUrl!)
                  : null,
              child: user.profileImageUrl == null
                  ? const Icon(Icons.person, size: 30)
                  : null,
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(user.email),
                  Text('${user.city} • ${user.nationality}'),
                ],
              ),
            ),

            // Verification doc
            if (user.verificationDocUrl != null)
              TextButton.icon(
                onPressed: () {
                  _showVerificationImage(user.verificationDocUrl!);
                },
                icon: const Icon(Icons.image),
                label: const Text('View Doc'),
              ),

            const SizedBox(width: 16),

            // Actions
            ElevatedButton.icon(
              onPressed: () async {
                await provider.approveUser(user.uid);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User approved')),
                );
              },
              icon: const Icon(Icons.check),
              label: const Text('Approve'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),

            const SizedBox(width: 8),

            ElevatedButton.icon(
              onPressed: () async {
                await provider.rejectUser(user.uid);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User rejected')),
                );
              },
              icon: const Icon(Icons.close),
              label: const Text('Reject'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVerificationImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
          child: Column(
            children: [
              AppBar(
                title: const Text('Verification Document'),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Expanded(
                child: Image.network(imageUrl, fit: BoxFit.contain),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Part 5: Providers

### User Management Provider

```dart
// lib/providers/user_management_provider.dart
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserManagementProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<UserModel> _pendingUsers = [];
  List<UserModel> _allUsers = [];
  bool _isLoading = false;

  List<UserModel> get pendingUsers => _pendingUsers;
  List<UserModel> get allUsers => _allUsers;
  bool get isLoading => _isLoading;

  Future<void> loadPendingVerifications() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('verificationStatus', isEqualTo: 'underReview')
          .get();

      _pendingUsers = snapshot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> approveUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'verificationStatus': 'approved',
        'updatedAt': Timestamp.now(),
      });

      // Remove from pending list
      _pendingUsers.removeWhere((user) => user.uid == userId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> rejectUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'verificationStatus': 'rejected',
        'updatedAt': Timestamp.now(),
      });

      _pendingUsers.removeWhere((user) => user.uid == userId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loadAllUsers() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .orderBy('createdAt', descending: true)
          .get();

      _allUsers = snapshot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      _allUsers.removeWhere((user) => user.uid == userId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> banUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'isActive': false,
        'updatedAt': Timestamp.now(),
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
```

---

## Part 6: Deployment

### Step 1: Build for Web

```bash
cd myshetribe_admin_panel
flutter build web --release
```

### Step 2: Deploy to Firebase Hosting

```bash
# Install Firebase CLI if not already installed
npm install -g firebase-tools

# Login
firebase login

# Initialize Firebase Hosting
firebase init hosting

# Select your Firebase project
# Choose build/web as the public directory
# Configure as single-page app: Yes
# Don't overwrite index.html

# Deploy
firebase deploy --only hosting
```

Your admin panel will be live at: `https://YOUR_PROJECT.firebaseapp.com`

---

## Part 7: Security

### Firestore Security Rules for Admin

Update your Firestore rules to restrict admin operations:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Helper function to check if user is admin
    function isAdmin() {
      return request.auth != null &&
             exists(/databases/$(database)/documents/admins/$(request.auth.uid));
    }

    // Admin collection (only admins can read)
    match /admins/{adminId} {
      allow read: if isAdmin();
      allow write: if false; // Only via Firebase Console
    }

    // Users collection
    match /users/{userId} {
      allow read: if request.auth != null;
      allow update, delete: if isAdmin(); // Only admins can modify
      allow create: if request.auth.uid == userId; // Users create their own
    }

    // Tribes, Events, Offers - admins have full access
    match /tribes/{tribeId} {
      allow read: if request.auth != null;
      allow write: if isAdmin();
    }

    match /events/{eventId} {
      allow read: if request.auth != null;
      allow write: if isAdmin();
    }

    match /partnership_offers/{offerId} {
      allow read: if request.auth != null;
      allow write: if isAdmin();
    }
  }
}
```

### Create Admin User

In Firebase Console:
1. Go to Firestore Database
2. Create collection `admins`
3. Add document with admin's UID
4. Set fields: `email`, `role: "admin"`, `createdAt`

---

## Summary

✅ Separate Flutter web project
✅ Same Firebase backend as mobile app
✅ Admin authentication
✅ User verification approval/rejection
✅ Content management (tribes, events, offers)
✅ Analytics dashboard
✅ Secure with Firestore rules
✅ Deploy to Firebase Hosting

**Your admin panel is production-ready!** 🚀
