# Complete Screen Integration Guide

This document provides ready-to-use code for integrating ALL remaining screens with Firebase. Simply copy-paste the code for each screen.

## Pattern Overview

All integrations follow this pattern:
1. Import providers
2. Wrap UI with `Consumer<Provider>`
3. Load data in `initState`
4. Display data from provider
5. Handle loading/error states

---

## 1. EVENTS SCREEN (`lib/screens/events/view/events_screen.dart`)

### Add these imports at the top:
```dart
import 'package:provider/provider.dart';
import 'package:myshetribe/providers/event_provider.dart';
import 'package:myshetribe/providers/auth_provider.dart';
```

### Add initState to load events:
```dart
@override
void initState() {
  super.initState();
  Future.microtask(() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userCity = authProvider.currentUser?.city;
    Provider.of<EventProvider>(context, listen: false)
        .loadUpcomingEvents(city: userCity);
  });
}
```

### Wrap your events list with Consumer:
```dart
Consumer<EventProvider>(
  builder: (context, eventProvider, child) {
    if (eventProvider.isLoading) {
      return Center(child: CircularProgressIndicator(color: Color(0xFF3A3A3A)));
    }

    if (eventProvider.events.isEmpty) {
      return Center(
        child: Text(
          'No upcoming events',
          style: GoogleFonts.poppins(fontSize: 16, color: Color(0xFF2C2C2C)),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: eventProvider.events.length,
      itemBuilder: (context, index) {
        final event = eventProvider.events[index];

        // YOUR EXISTING EVENT CARD WIDGET HERE
        // Just pass event data to your existing design
        return YourEventCard(event: event);
      },
    );
  },
)
```

---

## 2. EVENT DETAILS SCREEN (`lib/screens/events/view/event_details_screen.dart`)

### Add imports:
```dart
import 'package:provider/provider.dart';
import 'package:myshetribe/providers/event_provider.dart';
import 'package:myshetribe/providers/auth_provider.dart';
import 'package:myshetribe/models/event_model.dart';
```

### Modify class to accept eventId:
```dart
class EventDetailsScreen extends StatefulWidget {
  final String eventId;
  const EventDetailsScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}
```

### Load event in initState:
```dart
EventModel? _event;

@override
void initState() {
  super.initState();
  _loadEventDetails();
}

Future<void> _loadEventDetails() async {
  final eventProvider = Provider.of<EventProvider>(context, listen: false);
  final event = await eventProvider.getEvent(widget.eventId);
  if (mounted) {
    setState(() {
      _event = event;
    });
  }
}
```

### RSVP Button with Firebase:
```dart
Consumer<EventProvider>(
  builder: (context, eventProvider, child) {
    return ElevatedButton(
      onPressed: eventProvider.isLoading ? null : () async {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final userId = authProvider.currentUser?.uid;

        if (userId != null && _event != null) {
          bool success = await eventProvider.rsvpEvent(
            _event!.id,
            userId,
            _event!.title,
          );

          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('RSVP successful!'), backgroundColor: Colors.green),
            );
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3A3A3A),
        // Your existing button style
      ),
      child: eventProvider.isLoading
          ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
          : Text('RSVP', style: GoogleFonts.poppins(/* your style */)),
    );
  },
)
```

---

## 3. MY EVENTS SCREEN (`lib/screens/events/view/my_events_screen.dart`)

### Add imports:
```dart
import 'package:provider/provider.dart';
import 'package:myshetribe/providers/event_provider.dart';
import 'package:myshetribe/providers/auth_provider.dart';
```

### Load user's events:
```dart
@override
void initState() {
  super.initState();
  Future.microtask(() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.currentUser?.uid;
    if (userId != null) {
      Provider.of<EventProvider>(context, listen: false).loadMyEvents(userId);
    }
  });
}
```

### Display user's events:
```dart
Consumer<EventProvider>(
  builder: (context, eventProvider, child) {
    if (eventProvider.isLoading) {
      return Center(child: CircularProgressIndicator(color: Color(0xFF3A3A3A)));
    }

    return ListView.builder(
      itemCount: eventProvider.myEvents.length,
      itemBuilder: (context, index) {
        final event = eventProvider.myEvents[index];
        return YourEventCard(event: event); // Your existing design
      },
    );
  },
)
```

---

## 4. PARTNERSHIP OFFERS SCREEN (`lib/screens/partnership_offers/view/partnership_offer_screen.dart`)

### Add imports:
```dart
import 'package:provider/provider.dart';
import 'package:myshetribe/providers/partnership_provider.dart';
import 'package:myshetribe/providers/auth_provider.dart';
```

### Load offers:
```dart
@override
void initState() {
  super.initState();
  Future.microtask(() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userCity = authProvider.currentUser?.city;
    Provider.of<PartnershipProvider>(context, listen: false)
        .loadOffers(city: userCity);
  });
}
```

### Display offers:
```dart
Consumer<PartnershipProvider>(
  builder: (context, partnershipProvider, child) {
    if (partnershipProvider.isLoading) {
      return Center(child: CircularProgressIndicator(color: Color(0xFF3A3A3A)));
    }

    if (partnershipProvider.offers.isEmpty) {
      return Center(
        child: Text(
          'No offers available',
          style: GoogleFonts.poppins(fontSize: 16, color: Color(0xFF2C2C2C)),
        ),
      );
    }

    return ListView.builder(
      itemCount: partnershipProvider.offers.length,
      itemBuilder: (context, index) {
        final offer = partnershipProvider.offers[index];

        // YOUR EXISTING OFFER CARD
        return YourOfferCard(
          offer: offer,
          onTap: () async {
            // Track view
            await partnershipProvider.viewOffer(offer.id, offer.title);
            // Navigate to details or show dialog
          },
          onRedeem: () async {
            // Redeem offer
            bool success = await partnershipProvider.redeemOffer(
              offer.id,
              offer.title,
            );
            if (success) {
              // Show discount code dialog
              showDialog(/* your design with offer.discountCode */);
            }
          },
        );
      },
    );
  },
)
```

---

## 5. SETTINGS SCREEN (`lib/screens/settings_screen/view/settings_screen.dart`)

### Add imports:
```dart
import 'package:provider/provider.dart';
import 'package:myshetribe/providers/auth_provider.dart';
import 'package:myshetribe/providers/user_provider.dart';
```

### Display user info:
```dart
Consumer2<AuthProvider, UserProvider>(
  builder: (context, authProvider, userProvider, child) {
    final user = authProvider.currentUser;

    return Column(
      children: [
        // Profile section
        Text(user?.fullName ?? 'User', style: GoogleFonts.poppins(/* style */)),
        Text(user?.email ?? '', style: GoogleFonts.poppins(/* style */)),

        // Your existing settings options

        // Logout button
        ElevatedButton(
          onPressed: authProvider.isLoading ? null : () async {
            await authProvider.signOut();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3A3A3A),
            // Your button style
          ),
          child: authProvider.isLoading
              ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
              : Text('Logout', style: GoogleFonts.poppins(/* style */)),
        ),
      ],
    );
  },
)
```

---

## 6. MY PROFILE SCREEN (`lib/screens/profile/view/my_profile_screen.dart`)

### Add imports:
```dart
import 'package:provider/provider.dart';
import 'package:myshetribe/providers/user_provider.dart';
import 'package:myshetribe/providers/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
```

### Load and display user profile:
```dart
@override
void initState() {
  super.initState();
  Future.microtask(() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.currentUser?.uid;
    if (userId != null) {
      Provider.of<UserProvider>(context, listen: false).loadUser(userId);
    }
  });
}
```

### Display profile:
```dart
Consumer2<UserProvider, AuthProvider>(
  builder: (context, userProvider, authProvider, child) {
    final user = userProvider.user ?? authProvider.currentUser;

    if (userProvider.isLoading) {
      return Center(child: CircularProgressIndicator(color: Color(0xFF3A3A3A)));
    }

    return Column(
      children: [
        // Profile image
        CircleAvatar(
          radius: 50,
          backgroundImage: user?.profileImageUrl != null
              ? NetworkImage(user!.profileImageUrl!)
              : null,
          child: user?.profileImageUrl == null
              ? Icon(Icons.person, size: 50)
              : null,
        ),

        // Upload photo button
        TextButton.icon(
          onPressed: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(source: ImageSource.gallery);

            if (image != null && authProvider.currentUser != null) {
              await userProvider.uploadProfileImage(File(image.path));
            }
          },
          icon: Icon(Icons.camera_alt),
          label: Text('Change Photo'),
        ),

        // Display user info
        Text(user?.fullName ?? '', style: GoogleFonts.poppins(/* style */)),
        Text(user?.email ?? '', style: GoogleFonts.poppins(/* style */)),
        Text(user?.city ?? '', style: GoogleFonts.poppins(/* style */)),

        // Edit button
        ElevatedButton(
          onPressed: () {
            // Navigate to edit profile screen
          },
          child: Text('Edit Profile'),
        ),
      ],
    );
  },
)
```

---

## 7. BOOKING CONFIRMATION SCREEN (`lib/screens/booking_confirmation/view/booking_confirmation_screen.dart`)

### Add imports:
```dart
import 'package:provider/provider.dart';
import 'package:myshetribe/providers/event_provider.dart';
import 'package:myshetribe/providers/auth_provider.dart';
import 'package:myshetribe/models/event_model.dart';
```

### Modify to accept event:
```dart
class BookingConfirmationScreen extends StatelessWidget {
  final EventModel event;
  const BookingConfirmationScreen({Key? key, required this.event}) : super(key: key);
```

### Confirm booking button:
```dart
Consumer2<EventProvider, AuthProvider>(
  builder: (context, eventProvider, authProvider, child) {
    return ElevatedButton(
      onPressed: eventProvider.isLoading ? null : () async {
        final userId = authProvider.currentUser?.uid;

        if (userId != null) {
          bool success = await eventProvider.createBooking(
            userId: userId,
            eventId: event.id,
            eventTitle: event.title,
            eventDate: event.eventDate,
            amount: event.price,
            stripePaymentIntentId: null, // Add Stripe integration if needed
          );

          if (success) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => BookingSuccessScreen()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(eventProvider.errorMessage ?? 'Booking failed'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3A3A3A),
        // Your button style
      ),
      child: eventProvider.isLoading
          ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
          : Text('Confirm Booking', style: GoogleFonts.poppins(/* style */)),
    );
  },
)
```

---

## 8. MATCH DETAIL SCREEN (`lib/screens/match_detail_screen/view/match_detail_screen.dart`)

### Add imports:
```dart
import 'package:provider/provider.dart';
import 'package:myshetribe/providers/tribe_provider.dart';
import 'package:myshetribe/models/tribe_model.dart';
```

### Load tribe details:
```dart
class MatchDetailScreen extends StatefulWidget {
  final String tribeId;
  const MatchDetailScreen({Key? key, required this.tribeId}) : super(key: key);
}

class _MatchDetailScreenState extends State<MatchDetailScreen> {
  TribeModel? _tribe;

  @override
  void initState() {
    super.initState();
    _loadTribeDetails();
  }

  Future<void> _loadTribeDetails() async {
    final tribeProvider = Provider.of<TribeProvider>(context, listen: false);
    final tribe = await tribeProvider.getTribe(widget.tribeId);
    if (mounted) {
      setState(() {
        _tribe = tribe;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_tribe == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator(color: Color(0xFF3A3A3A))),
      );
    }

    // Display tribe details with your existing design
    return Scaffold(
      // Your design here, using _tribe data
      body: Column(
        children: [
          Text(_tribe!.name, style: GoogleFonts.poppins(/* style */)),
          Text(_tribe!.description, style: GoogleFonts.poppins(/* style */)),
          Text('${_tribe!.memberCount} members', style: GoogleFonts.poppins(/* style */)),
          // Join button
          Consumer<TribeProvider>(
            builder: (context, tribeProvider, child) {
              return ElevatedButton(
                onPressed: () async {
                  await tribeProvider.joinTribe(_tribe!.id, _tribe!.name);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Joined ${_tribe!.name}!')),
                  );
                },
                child: Text('Join Tribe'),
              );
            },
          ),
        ],
      ),
    );
  }
}
```

---

## 9. ABOUT/ONBOARDING SCREENS

### Tell Us About Screen (`lib/screens/about/view/tell_us_about_screen.dart`)

```dart
// Add imports
import 'package:provider/provider.dart';
import 'package:myshetribe/providers/user_provider.dart';
import 'package:myshetribe/providers/auth_provider.dart';

// Add bio controller
final TextEditingController _bioController = TextEditingController();

// Save button
Consumer<UserProvider>(
  builder: (context, userProvider, child) {
    return ElevatedButton(
      onPressed: userProvider.isLoading ? null : () async {
        bool success = await userProvider.updateProfile(
          bio: _bioController.text.trim(),
        );

        if (success) {
          Navigator.push(context, MaterialPageRoute(/* next screen */));
        }
      },
      child: userProvider.isLoading
          ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
          : Text('Next', style: GoogleFonts.poppins(/* style */)),
    );
  },
)
```

### Your UAE Plans (`lib/screens/about/view/your_uae_plans.dart`)
```dart
// Similar pattern - save selected plan to user profile
await userProvider.updateProfile(
  // Add custom field for UAE plans
);
```

### What Help Do You Need (`lib/screens/about/view/what_help_do_you_need.dart`)
```dart
// Save help needed categories
await userProvider.updateProfile(
  // Add custom field for help categories
);
```

---

## 10. SERVICE SCREENS (Accommodation, Health, Employment)

These screens need custom Firestore collections. Here's the pattern:

### Create Service Model (`lib/models/service_model.dart`)
```dart
class ServiceModel {
  final String id;
  final String title;
  final String description;
  final String category; // 'accommodation', 'health', 'employment'
  final String? imageUrl;
  final String? contactInfo;
  final String city;
  final DateTime createdAt;
  final bool isActive;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.imageUrl,
    this.contactInfo,
    required this.city,
    required this.createdAt,
    this.isActive = true,
  });

  factory ServiceModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ServiceModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      imageUrl: data['imageUrl'],
      contactInfo: data['contactInfo'],
      city: data['city'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      isActive: data['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'contactInfo': contactInfo,
      'city': city,
      'createdAt': Timestamp.fromDate(createdAt),
      'isActive': isActive,
    };
  }
}
```

### Service Provider (`lib/providers/service_provider.dart`)
```dart
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myshetribe/models/service_model.dart';

class ServiceProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<ServiceModel> _services = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ServiceModel> get services => _services;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadServices(String category, {String? city}) async {
    try {
      _isLoading = true;
      notifyListeners();

      Query query = _firestore
          .collection('services')
          .where('category', isEqualTo: category)
          .where('isActive', isEqualTo: true);

      if (city != null) {
        query = query.where('city', isEqualTo: city);
      }

      QuerySnapshot snapshot = await query.get();
      _services = snapshot.docs
          .map((doc) => ServiceModel.fromFirestore(doc))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
```

### Add to main.dart providers:
```dart
ChangeNotifierProvider(create: (_) => ServiceProvider()),
```

### Use in screens:
```dart
// Accommodation Screen
@override
void initState() {
  super.initState();
  Future.microtask(() =>
    Provider.of<ServiceProvider>(context, listen: false)
        .loadServices('accommodation', city: userCity)
  );
}

Consumer<ServiceProvider>(
  builder: (context, serviceProvider, child) {
    if (serviceProvider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: serviceProvider.services.length,
      itemBuilder: (context, index) {
        final service = serviceProvider.services[index];
        return YourServiceCard(service: service);
      },
    );
  },
)
```

---

## Summary

**All backend infrastructure is ready!** Each screen integration follows the same pattern:

1. ✅ Import provider
2. ✅ Load data in `initState`
3. ✅ Wrap UI with `Consumer`
4. ✅ Use provider data in existing design
5. ✅ Handle loading/error states

**Your design remains 100% unchanged** - you're just feeding Firebase data into your existing widgets!

---

## Testing Checklist

After integration:
- [ ] Login works
- [ ] Signup creates user in Firestore
- [ ] Profile setup saves data
- [ ] Events load and display
- [ ] Partnership offers load
- [ ] RSVP creates bookings
- [ ] Settings logout works
- [ ] Profile image upload works
- [ ] Verification doc upload works

All providers and services are ready - just apply these patterns! 🚀
