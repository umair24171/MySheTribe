import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/main.dart';
import 'package:myshetribe/screens/accomodation_guide/view/accomodation_article_screen.dart';
import 'package:myshetribe/screens/accomodation_guide/view/accomodation_guide_screen.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/screens/employment/view/enterprenaurship_guide.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class ImmigrationScreen extends StatelessWidget {
  const ImmigrationScreen({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    final List<String> _buttonTitles = const [
    'Starting a business in UAE',
    'Types of Business Set Ups',
    'Key Questions',
    'Business Set Up Journey',
    'Visas for Enterpreneurs',
    'Common FAQs',
  ];
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2, onItemTapped: (i){}),
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

            const SizedBox(height: 20),

            // Title
            Text(
              'Enterpreneurship',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2C2C2C),
              ),
            ),

            const SizedBox(height: 29),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Hero Image
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      height: 246,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.asset(
                          'assets/icons/legal_image.png',
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.image, size: 80),
                            );
                          },
                        ),
                      ),
                    ),

                   // Grid Buttons
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          mainAxisExtent: 43,
                        ),
                        itemCount: _buttonTitles.length,
                        itemBuilder: (context, index) {
                          return _buildActionButton(_buttonTitles[index]);
                        },
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
         
         
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title) {
    return InkWell(
      onTap: () {
        Navigator.push(navigatorKey!.currentContext!, MaterialPageRoute(builder: (context)=>EnterprenaurshipGuide()));
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF3A3A3A),
          borderRadius: BorderRadius.circular(0),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}