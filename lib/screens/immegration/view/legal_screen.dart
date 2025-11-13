import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/accomodation_guide/view/accomodation_guide_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      body: SafeArea(
        child: Column(
          children: [
            // Header
             const SizedBox(height: 20),
          LogoHeader(),
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

            const SizedBox(height: 10),

            // Title
            Text(
              'Legal',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2C2C2C),
              ),
            ),

             const SizedBox(height: 10),
   // Content
            Expanded(
              child: Container(
                 color: Color(0xffFe9cb4),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  children: [
                    // Guide Card
                    InkWell(
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>AccommodationGuideScreen()));
                      },
                      child: _buildGuideCard(
                        'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=800',
                        'Guide',
                        'Top Ten Suburbs to\nlive in Dubai',
                      ),
                    ),
                
                    const SizedBox(height: 30),
                
                    // CONNECT WITH PARTNERS Header
                    Center(
                      child: Text(
                        'CONNECT WITH PARTNERS',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2C2C2C),
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                
                    const SizedBox(height: 25),
                
                    // Real Estate Agents Card
                    _buildPartnerCard(
                      'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=800',
                      'Real Estate\nAgents',
                      'Female Friendly\nAgents',
                    ),
                
                    const SizedBox(height: 20),
                
                    // Find Accommodation Card
                    _buildPartnerCard(
                      'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=800',
                      'Find\nAccommodation',
                      'Bayut\nProperty Finder\nDubizzle',
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

  Widget _buildGuideCard(String imageUrl, String title, String subtitle) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              bottomLeft: Radius.circular(0),
            ),
            child: Image.network(
              imageUrl,
              width: 180,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),
          // Text Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2C2C2C),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2C2C2C),
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerCard(String imageUrl, String title, String subtitle) {
    return Container(
      height: 130 ,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              bottomLeft: Radius.circular(0),
            ),
            child: Image.network(
              imageUrl,
              width: 180,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),
          // Text Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2C2C2C),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    flex: 10,
                    child: Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2C2C2C),
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
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