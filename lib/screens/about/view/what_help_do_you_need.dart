import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/about/view/thank_you_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class WhatHelpDoYouNeedScreen extends StatefulWidget {
  const WhatHelpDoYouNeedScreen({Key? key}) : super(key: key);

  @override
  State<WhatHelpDoYouNeedScreen> createState() => _WhatHelpDoYouNeedScreenState();
}

class _WhatHelpDoYouNeedScreenState extends State<WhatHelpDoYouNeedScreen> {
  final Map<String, bool> supportNeeds = {
    'Accommodation': false,
    'Employment/ Career': false,
    'Budgeting/ Cost of living': false,
    'Schools, Children': false,
    'Social Support': false,
    'Other': false,
  };
  
  String? pairWithBuddy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      body: SafeArea(
        child: Column(
          children: [
const SizedBox(height: 30),
            LogoHeader(),
            // Header
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 20),
            //   child: Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           CustomPaint(
            //             size: const Size(40, 40),
            //             painter: DottedHeartPainter(),
            //           ),
            //           const SizedBox(width: 8),
            //           Icon(
            //             Icons.eco,
            //             color: Colors.white.withOpacity(0.9),
            //             size: 30,
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: 8),
            //       Text(
            //         'UAE',
            //         style: GoogleFonts.poppins(
            //           fontSize: 16,
            //           fontWeight: FontWeight.w600,
            //           color: Colors.white,
            //           letterSpacing: 2,
            //         ),
            //       ),
            //       Text(
            //         'MySheTribe',
            //         style: GoogleFonts.poppins(
            //           fontSize: 32,
            //           fontWeight: FontWeight.w700,
            //           color: Colors.white,
            //           letterSpacing: 1,
            //         ),
            //       ),
            //       const SizedBox(height: 5),
            //       Text(
            //         'CONNECTING WOMEN,',
            //         style: GoogleFonts.poppins(
            //           fontSize: 12,
            //           fontWeight: FontWeight.w400,
            //           color: Colors.white,
            //           letterSpacing: 2,
            //         ),
            //       ),
            //       Text(
            //         'CREATING COMMUNITY',
            //         style: GoogleFonts.poppins(
            //           fontSize: 12,
            //           fontWeight: FontWeight.w400,
            //           color: Colors.white,
            //           letterSpacing: 2,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            const SizedBox(height: 20),

            // Title
            Text(
              'What help do you need?',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2C2C2C),
              ),
            ),

            const SizedBox(height: 10),

            // Form
            Expanded(
              child: Container(
                 color: Color(0xffFe9cb4),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2 to 3
                      Text(
                        '2 to 3',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2C2C2C),
                        ),
                      ),
                      const SizedBox(height: 15),
                
                      // Why support do you require?
                      Text(
                        'Why support do you require?',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2C2C2C),
                        ),
                      ),
                      const SizedBox(height: 15),
                
                      // Checkboxes
                      ...supportNeeds.keys.map((key) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _buildCheckboxOption(key),
                      )),
                      
                      const SizedBox(height: 30),
                
                      // Would you like to paired with a buddy?
                      Text(
                        'Would you like to paired with a\nbuddy?',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2C2C2C),
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildRadioOption('Yes', 'yes'),
                      const SizedBox(height: 10),
                      _buildRadioOption('No', 'no'),
                      
                      const SizedBox(height: 50),
                
                      // Submit Button
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 317,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                               Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ThankYouScreen()),
                          );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            child: Text(
                              'Submit',
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
            ),

            // Bottom Navigation
            // _buildBottomNav(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxOption(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          supportNeeds[label] = !supportNeeds[label]!;
        });
      },
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
              color: supportNeeds[label]! ? Colors.black : Colors.transparent,
            ),
            child: supportNeeds[label]!
                ? const Center(
                    child: Icon(Icons.circle, size: 12, color: Colors.white),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2C2C2C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String label, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          pairWithBuddy = value;
        });
      },
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
              color: pairWithBuddy == value ? Colors.black : Colors.transparent,
            ),
            child: pairWithBuddy == value
                ? const Center(
                    child: Icon(Icons.circle, size: 12, color: Colors.white),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2C2C2C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFF3D3D3D),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.people, false),
          _buildNavItem(Icons.calendar_month, false),
          _buildNavItem(null, true),
          _buildNavItem(Icons.chat_bubble, false),
          _buildNavItem(Icons.person, false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData? icon, bool isHome) {
    if (isHome) {
      return Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          color: Color(0xFFFFB6C8),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.home, color: Color(0xFF3D3D3D), size: 28),
      );
    }
    return Icon(icon, color: const Color(0xFFFFB6C8), size: 28);
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