import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/screens/events/view/events_screen.dart';
import 'package:myshetribe/screens/support_hub/view/support_hub_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      body: SafeArea(
        child: Column(
          children: [
 const SizedBox(height: 10),
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
            //   ),            // ),

            const SizedBox(height: 29),

            // Title
            Text(
              'Thank you, you\'re all set',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF3A3A3A),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 29),

            // Buttons
            Container(

              height: 400,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFE9CB4),
                        borderRadius: BorderRadius.circular(0),
                      ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(height: 22),
                    _buildButton(
                      'View Suggested resources',
                      () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainNavigationScreen()),
                      );
                      },
                    ),
                    const SizedBox(height: 22),
                    _buildButton(
                      'Explore Support Hub',
                      () {
                          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SupportHubScreen()),
                      );
                      },
                    ),
                    const SizedBox(height: 22),
                    _buildButton(
                      'Upcoming Events',
                      () {
                          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventsScreen()),
                      );
                      },
                    ),
                     const SizedBox(height: 22),
                       _buildButton(
                      'Useful Links',
                      () {
                          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainNavigationScreen()),
                      );
                      },
                    ),
                     const SizedBox(height: 22),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            // _buildBottomNav(context),
          ],
        ),
      ),
       bottomNavigationBar: CustomBottomNavBar(selectedIndex:2 ,onItemTapped: (p0) {
        
      },),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xFF3A3A3A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.white,
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