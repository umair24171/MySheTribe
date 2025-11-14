import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/events/view/events_screen.dart';
import 'package:myshetribe/screens/events/view/my_events_screen.dart';
import 'package:myshetribe/screens/main_chat_lounge/view/main_chat_lounge_screen.dart';
import 'package:myshetribe/screens/my_matches/view/my_matches_screen.dart';
import 'package:myshetribe/screens/partnership_offers/view/partnership_offer_screen.dart';
import 'package:myshetribe/screens/relocating_signup_screen/view/relocating_signup_screen.dart';
import 'package:myshetribe/screens/support_hub/view/support_hub_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int _selectedIndex = 2; // Home is selected by default

  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'My Matches',
      'image': 'assets/icons/my_matches_image.png',
      'route': 'matches',
    },
    {
      'title': 'My Chats',
      'image': 'assets/icons/chats_image.png',
      'route': 'chats',
    },
    {
      'title': 'My Events',
      'image': 'assets/icons/my_events_image.png',
      'route': 'events',
    },
    {
      'title': 'My Support Hub',
      'image': 'assets/icons/my_support_image.png',
      'route': 'support_hub',
    },
    {
      'title': 'Relocating to UAE',
      'image': 'assets/icons/relocating_image.png',
      'route': 'relocating_uae',
    },
    {
      'title': 'Partnership Offers',
      'image': 'assets/icons/partnership_offers.png',
      'route': 'partnership_offers',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
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
                    
                    // Main Menu Title
                    Text(
                      'Main Menu',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2C2C2C),
                      ),
                    ),
                    
                    const SizedBox(height: 29),
                    
                    // Main Content Container - FIXED HEIGHT 360
                    Container(
                      height: 400,
                      margin: const EdgeInsets.symmetric(horizontal: 19),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFE9CB4),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Container(
                        // color: Colors.white,
                       margin: const EdgeInsets.symmetric(horizontal: 22),
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0).copyWith(top: 22,bottom: 2),
                        child: GridView.builder(
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
                    
                    const SizedBox(height: 0),
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
      case 'matches':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyMatchesScreen()),
        );
        break;
      case 'chats':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainChatLoungeScreen()),
        );
        break;
      case 'events':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventsScreen()),
        );
        break;
      case 'support_hub':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SupportHubScreen()),
        );
        break;
      case 'relocating_uae':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RelocatingSignUpScreen()),
        );
        break;
      case 'partnership_offers':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PartnershipOffersScreen()),
        );
        break;
    }
  }
}