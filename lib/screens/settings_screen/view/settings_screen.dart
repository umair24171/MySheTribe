import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/about_shetribe/view/about_shetribe.dart';
import 'package:myshetribe/screens/accomodation/view/accomodation_screen.dart';
import 'package:myshetribe/screens/accomodation_guide/view/accomodation_guide_screen.dart';
import 'package:myshetribe/screens/employment/view/employment_screen.dart';
import 'package:myshetribe/screens/health/view/health_screen.dart';
import 'package:myshetribe/screens/immegration/view/immegration_screen.dart';
import 'package:myshetribe/screens/partnership_offers/view/partnership_offer_screen.dart';
import 'package:myshetribe/screens/profile/view/my_profile_screen.dart';
import 'package:myshetribe/screens/support_hub/view/support_hub_screen.dart';
import 'package:myshetribe/screens/terms_condition/view/terms_condition.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Support Hub',
      'icon': Icons.support_agent,
      'route': SupportHubScreen(),
    },
    {
      'title': 'Accommodation',
      'icon': Icons.home_outlined,
      'route': AccommodationScreen(),
    },
    {
      'title': 'Accommodation Guide',
      'icon': Icons.menu_book_outlined,
      'route': AccommodationGuideScreen(),
    },
    {
      'title': 'Employment',
      'icon': Icons.work_outline,
      'route': EmploymentScreen(),
    },
    {
      'title': 'Health',
      'icon': Icons.favorite_outline,
      'route':HealthScreen(),
    },
    {
      'title': 'Immigration',
      'icon': Icons.flight_takeoff_outlined,
      'route': ImmigrationScreen(),
    },
    {
      'title': 'Legal',
      'icon': Icons.gavel_outlined,
      'route':ImmigrationScreen(),
    },
    {
      'title': 'Public Services',
      'icon': Icons.location_city_outlined,
      'route': ImmigrationScreen(),
    },
    {
      'title': 'My Profile',
      'icon': Icons.person_outline,
      'route':MyProfileScreen(),
    },
    {
      'title': 'About MySheTribe',
      'icon': Icons.info_outline,
      'route': AboutMySheTribeScreen(),
    },
    {
      'title': 'Terms & Conditions',
      'icon': Icons.description_outlined,
      'route':TermsConditionsScreen(),
    },
    {
      'title': 'Partnership Offers',
      'icon': Icons.card_giftcard_outlined,
      'route': PartnershipOffersScreen(),
    },
  ];

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFFFB6C8),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header Logo
            _buildHeader(),
            const SizedBox(height: 25),
            // Settings Title
            Text(
              'Settings',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2C2C2C),
              ),
            ),
            const SizedBox(height: 20),
            // Menu Items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return _buildMenuItem(menuItems[index]);
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}
  Widget _buildHeader() {
    return LogoHeader();
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        // Navigate to respective screen
        _navigateToScreen(item['route']);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: const Color(0xFFD4A574),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                item['icon'],
                color: const Color(0xFF2C2C2C),
                size: 24,
              ),
            ),
            const SizedBox(width: 15),
            // Title
            Expanded(
              child: Text(
                item['title'],
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2C2C2C),
                ),
              ),
            ),
            // Arrow Icon
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF2C2C2C),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToScreen(Widget route) {
    // Show a message for now - replace with actual navigation
   Navigator.push(context, MaterialPageRoute(builder: (context)=>route));

    // TODO: Add actual navigation when screens are ready
    // Example:
    // switch (route) {
    //   case 'support_hub':
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => SupportHubScreen()));
    //     break;
    //   case 'accommodation':
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => AccommodationScreen()));
    //     break;
    //   // ... add all other cases
    // }
  }
}
