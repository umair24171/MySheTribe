import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/about_shetribe/view/about_shetribe.dart';
import 'package:myshetribe/screens/sidebar_screens/view/help_support_screen.dart';
import 'package:myshetribe/screens/sidebar_screens/view/privacy_policy.dart';
import 'package:myshetribe/screens/terms_condition/view/terms_condition.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Menu and Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Menu Icon
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.menu,
                          color: Color(0xFF3A3A3A),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  // Search Icon
                  // GestureDetector(
                  //   onTap: () {
                  //     // Navigate to search screen
                  //   },
                  //   child: Container(
                  //     width: 40,
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: const Icon(
                  //       Icons.search,
                  //       color: Color(0xFF3A3A3A),
                  //       size: 24,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    LogoHeader(),
                    const SizedBox(height: 20),

                    // Profile Picture
                    Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF6B8A),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/icons/camera_profile.png',
                              height: 20,
                              width: 23,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // Form Fields
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 19),
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFE9CB4),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          children: [
                            _buildTextField('Change Name'),
                            const SizedBox(height: 22),
                            _buildTextField('Enter New Password', isPassword: true),
                            const SizedBox(height: 22),
                            _buildTextField('Change Phone Number', keyboardType: TextInputType.phone),
                            const SizedBox(height: 22),
                            _buildButton('Log Out', () {
                              // Log out action
                            }),
                            const SizedBox(height: 22),
                            _buildButton('Delete Account', () {
                              // Delete account action
                            }),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 29),

                    // Save Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            // Save action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff3A3A3A),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: Text(
                            'Save',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFFB6C8),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Logo in Drawer
            Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Divider
            Container(
              height: 2,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFE9CB4),
                borderRadius: BorderRadius.circular(0),
              ),
            ),

            const SizedBox(height: 20),

            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // _buildDrawerItem(
                  //   context,
                  //   icon: Icons.home,
                  //   title: 'Home',
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     // Navigate to Home
                  //   },
                  // ),
                  // _buildDrawerItem(
                  //   context,
                  //   icon: Icons.person,
                  //   title: 'My Profile',
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.info_outline,
                    title: 'About MySheTribe',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutMySheTribeScreen()));
                      // Navigate to About screen
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.description_outlined,
                    title: 'Terms & Conditions',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsConditionsScreen()));
                      // Navigate to Terms & Conditions screen
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicyScreen()));
                      // Navigate to Privacy Policy screen
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpSupportScreen()));
                      // Navigate to Help & Support screen
                    },
                  ),
                  // _buildDrawerItem(
                  //   context,
                  //   icon: Icons.settings,
                  //   title: 'Settings',
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     // Navigate to Settings screen
                  //   },
                  // ),
                ],
              ),
            ),

            // Logout at Bottom
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFE9CB4),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Color(0xFF3A3A3A),
                  ),
                  title: Text(
                    'Logout',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3A3A3A),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // Handle logout
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFF3A3A3A),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF3A3A3A),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildTextField(String label, {bool isPassword = false, TextInputType keyboardType = TextInputType.text}) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: TextField(
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF2C2C2C),
        ),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF2C2C2C),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF2C2C2C),
          ),
        ),
      ),
    );
  }
}

class DottedHeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.3);
    path.cubicTo(
      size.width * 0.2, size.height * 0.1,
      size.width * 0.1, size.height * 0.4,
      size.width * 0.5, size.height * 0.8,
    );
    path.cubicTo(
      size.width * 0.9, size.height * 0.4,
      size.width * 0.8, size.height * 0.1,
      size.width * 0.5, size.height * 0.3,
    );

    final dashWidth = 5.0;
    final dashSpace = 3.0;
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final segment = pathMetric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(segment, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}