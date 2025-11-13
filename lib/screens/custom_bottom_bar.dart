import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/events/view/events_screen.dart';
import 'package:myshetribe/screens/events/view/my_events_screen.dart';
import 'package:myshetribe/screens/main_chat_lounge/view/main_chat_lounge_screen.dart';
import 'package:myshetribe/screens/main_menu/view/main_menu_screen.dart';
import 'package:myshetribe/screens/my_matches/view/my_matches_screen.dart';
import 'package:myshetribe/screens/profile/view/my_profile_screen.dart' hide DottedHeartPainter;
import 'package:myshetribe/screens/settings_screen/view/settings_screen.dart';

// Main Navigation Screen with Bottom Bar
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 2; // Home is selected by default

  // All screens for bottom navigation
  final List<Widget> _screens = [
    const MyMatchesScreen(),
    const EventsScreen(),
    const MainMenuScreen(),
    const MainChatLoungeScreen(),
    const MyProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// Reusable Custom Bottom Navigation Bar
class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(child: _buildNavItem('assets/icons/my_match.png', 'My Match', 0,context)),
              Expanded(child: _buildNavItem('assets/icons/events.png', 'Events', 1,context)),
              Expanded(child: _buildNavItem('', 'Home', 2,context)),
              Expanded(child: _buildNavItem('assets/icons/chats.png', 'Chat', 3,context)),
              Expanded(child: _buildNavItem('assets/icons/profile.png', 'Profile', 4,context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, int index,context) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFB6C8) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Center(
                child: index != 2
                    ? Image.asset(
                        icon,
                        height: 24,
                        width: 24,
                        fit: BoxFit.contain,
                      )
                    : Icon(
                        Icons.home,
                        color: isSelected ? Colors.white : const Color(0xFFF46B85),
                        size: 24,
                      ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                 fontSize: MediaQuery.of(context).size.width*0.026,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFFFFB6C8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}