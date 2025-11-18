import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/accomodation/view/accomodation_screen.dart';
import 'package:myshetribe/screens/accomodation/view/public_services.dart';
import 'package:myshetribe/screens/accomodation_guide/view/accomodation_guide_screen.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/screens/employment/view/employment_screen.dart';
import 'package:myshetribe/screens/health/view/health_screen.dart';
import 'package:myshetribe/screens/immegration/view/immegration_screen.dart';
import 'package:myshetribe/screens/immegration/view/legal_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class SupportHubScreen extends StatefulWidget {
  const SupportHubScreen({Key? key}) : super(key: key);

  @override
  State<SupportHubScreen> createState() => _SupportHubScreenState();
}

class _SupportHubScreenState extends State<SupportHubScreen> {
  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'Accommodation',
      'image': 'assets/icons/acccomodation.png',
      'route': 'accommodation',
    },
    {
      'title': 'Employment',
      'image': 'assets/icons/employment.png',
      'route': 'employment',
    },
    {
      'title': 'Enterpreneurship',
      'image': 'assets/icons/health.png',
      'route': 'health',
    },
    {
      'title': 'Health',
      'image': 'assets/icons/immegration.png',
      'route': 'immigration',
    },
    {
      'title': 'Legal',
      'image': 'assets/icons/legal.png',
      'route': 'legal',
    },
    {
      'title': 'Public Services',
      'image': 'assets/icons/public_service.png',
      'route': 'public_services',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
       bottomNavigationBar: CustomBottomNavBar(selectedIndex:2 ,onItemTapped: (p0) {
        
      },),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    // Logo and Branding Header
                    LogoHeader(),
                    const SizedBox(height: 29),
                    
                    // Support Hub Title
                    Text(
                      'Support Hub',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2C2C2C),
                      ),
                    ),
                    
                    const SizedBox(height: 19),
                    
                    // Main Content Container - FIXED HEIGHT 360
                    Container(
                      height: 400,
                      margin: const EdgeInsets.symmetric(horizontal: 19),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        // color: const Color(0xFFFE9CB4),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Container(
                        // color: Colors.white,
                       margin: const EdgeInsets.symmetric(horizontal: 0),
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0).copyWith(top: 22,bottom: 2),
                        child:   // Grid of Menu Items
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                  mainAxisExtent: 110,
                              ),
                              itemCount: _menuItems.length,
                              itemBuilder: (context, index) {
                                return _buildMenuCard(
                                  _menuItems[index]['title'],
                                  _menuItems[index]['image'],
                                  _menuItems[index]['route'],
                                );
                              },
                            ),
                      ),
                    ),
                    
                    // const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(String title, String imagePath, String route) {
    return GestureDetector(
      onTap: () {
        _navigateToScreen(route);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          children: [
            // Image on top
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 50),
                    );
                  },
                ),
              ),
            ),
            // Dark label below the image
            Container(
              width: MediaQuery.of(context).size.width * 0.37,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: const BoxDecoration(
                color: Color(0xFF3A3A3A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.037,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToScreen(String route) {
    switch (route) {
      case 'accommodation':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccommodationGuideScreen()),
        );
        break;
      case 'employment':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmploymentScreen()),
        );
        break;
      case 'health':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ImmigrationScreen()),
        );
        break;
      case 'immigration':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HealthScreen()),
        );
        break;
      case 'legal':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LegalScreen()),
        );
        break;
      case 'public_services':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PublicServices()),
        );
        break;
    }
  }
}