import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/screens/events/view/event_details_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({Key? key}) : super(key: key);

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  @override
  Widget build(BuildContext context) {

     final List<Map<String, dynamic>> upcomingEvents = [
    {
      'title': 'MyBrunchParty',
      'image': 'assets/icons/my_brunch_party.png',
    },
    {
      'title': 'MyDinnerParty',
      'image': 'assets/icons/my_dinner_party.png',
    },
     {
      'title': 'MyBusiness Forum',
      'image': 'assets/icons/my_dinner_party.png',
    },
     {
      'title': 'MyHighTea',
      'image': 'assets/icons/my_dinner_party.png',
    },
     {
      'title': 'MyLadies Lunch',
      'image': 'assets/icons/my_dinner_party.png',
    },
  ];
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
       bottomNavigationBar: CustomBottomNavBar(selectedIndex:1 ,onItemTapped: (p0) {
        
      },),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
            const SizedBox(height: 10),
              LogoHeader(),
              // // Header
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 20),
              //   child: Column(
              //     children: [
              //       // Logo Area
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           // Heart with dotted line
              //           CustomPaint(
              //             size: const Size(40, 40),
              //             painter: DottedHeartPainter(),
              //           ),
              //           const SizedBox(width: 8),
              //           // Butterfly
              //           Icon(
              //             Icons.eco,
              //             color: Colors.white.withOpacity(0.9),
              //             size: 30,
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 8),
              //       // UAE Text
              //       Text(
              //         'UAE',
              //         style: GoogleFonts.poppins(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w600,
              //           color: Colors.white,
              //           letterSpacing: 2,
              //         ),
              //       ),
              //       // MySheTribe
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
              //       // Tagline
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
          
              const SizedBox(height: 29),
          
              // MyEvents Title
              Text(
                'MyEvents',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2C2C2C),
                ),
              ),
          
              const SizedBox(height: 29),
          
              // Events List
             Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 19),
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFE9CB4),
                          borderRadius: BorderRadius.circular(0),
                        ),
                            child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // Text(
                                            //   'Upcoming Events',
                                            //   style: GoogleFonts.poppins(
                                            //     fontSize: 20,
                                            //     fontWeight: FontWeight.w700,
                                            //     color: const Color(0xFF2C2C2C),
                                            //   ),
                                            // ),
                                            // const SizedBox(height: 15),
                                            ...upcomingEvents.map((event) => _buildUpcomingEventCard(event)).toList(),
                                          ],
                                        ),
                            ),
                          ),
          
              // Bottom Navigation
              // _buildBottomNav(context),
            ],
          ),
        ),
      ),
    );
  }

 Widget _buildUpcomingEventCard(Map<String, dynamic> event) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 22),
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Row(
            children: [
              // Left side - Image (45% width)
              Container(
                height: 55,
                width: 98,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(event['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Right side - Gold section with label (55% width)
              Container(
                height: 98,
                width: MediaQuery.of(context).size.width*0.5,
                color: const Color(0xFFD4A574),
                child: Align(
                  alignment: Alignment(0.7, -0.99),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 28,
                        width: 154,
                        // padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF000000),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Text(
                          event['title'],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFD5A472),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                     '14 February 2026',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF3A3A3A),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    ],
                  ),
                ),
              ),
            ],
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

    // Draw dotted line
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