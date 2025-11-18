import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class PartnershipOffersScreen extends StatelessWidget {
  const PartnershipOffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2,onItemTapped: (p0) {
        
      },),
      body: SafeArea(
        child: Column(
          children: [
           const SizedBox(height: 10),
          LogoHeader(),
            const SizedBox(height: 29),

            // Title
            Text(
              'Partnership Offers',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2C2C2C),
              ),
            ),

            const SizedBox(height: 29),

            // Images List
            Expanded(
              // height: 400,
              child: Container(
                 decoration: BoxDecoration(
                        color: const Color(0xFFFE9CB4),
                        borderRadius: BorderRadius.circular(0),
                      ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 19,vertical: 22).copyWith(bottom: 0),
                  children: [
                    // First Image - Grocery Shopping
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset(
                        'assets/icons/partner_1.png',
                        width: double.infinity,
                        height: 224,
                        fit: BoxFit.cover,
                      ),
                    ),
                
                    const SizedBox(height: 22),
                
                    // Second Image - Clothing Store
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset(
                        'assets/icons/partner_2.png',
                        width: double.infinity,
                        height: 224,
                        fit: BoxFit.cover,
                      ),
                    ),
                
                    const SizedBox(height: 29),
                  ],
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