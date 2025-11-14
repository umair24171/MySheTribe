import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/screens/events/view/events_screen.dart';
import 'package:myshetribe/screens/events/view/my_events_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final String eventName;

  const BookingConfirmationScreen({
    Key? key,
    this.eventName = 'MyHighTea',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
       bottomNavigationBar: CustomBottomNavBar(selectedIndex:1 ,onItemTapped: (p0) {
        
      },),
      body: SafeArea(
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
            // Content Area
            Expanded(
              child: Container(
                width: double.infinity,
              
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 29),
                      // Booking Confirmation Title
                      Text(
                        'Booking Confirmation',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2C2C2C),
                        ),
                      ),
                      const SizedBox(height: 29),
                      
                   Container(
                    // height: 400,
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFE9CB4),
                        borderRadius: BorderRadius.circular(0),
                      ),
                    child: Column(children: [
                       // Checkmark Circle
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF8FA3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      const SizedBox(height: 30),
                      
                      // Confirmation Text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            Text(
                              'You are booked, your seat',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2C2C2C),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF2C2C2C),
                                ),
                                children: [
                                  const TextSpan(text: 'for '),
                                  TextSpan(
                                    text: eventName,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                       fontSize: 16,
                                    ),
                                  ),
                                   TextSpan(text: ' is confirmed.',style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                       fontSize: 16,
                                    ),),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'THANK YOU',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2C2C2C),
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      
                      // Buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            // Add to Calendar Button
                            _buildButton(
                              icon:'assets/icons/calender.png',
                              text: 'Add to Calendar',
                              onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>MyEventsScreen()));
                              },
                            ),
                            const SizedBox(height: 15),
                            
                            // View Event Details Button
                            _buildButton(
                              icon: 'assets/icons/event_details.png',
                              text: 'View Event Details',
                              onPressed: () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>MyEventsScreen()));
                              },
                            ),
                            const SizedBox(height: 15),
                            
                            // Go to Events Button
                            _buildButton(
                              icon: 'assets/icons/go_to_events.png',
                              text: 'Go to Events',
                              onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EventsScreen()));
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                   ],),)
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Navigation
          
          ],
        ),
      ),
    );
  }

 Widget _buildButton({
  required String icon,
  required String text,
  required VoidCallback onPressed,
}) {
  return Container(
    width: 364,
    height: 55,
    decoration: BoxDecoration(
      color: const Color(0xFFD5A472),
      borderRadius: BorderRadius.circular(0),
      border: Border.all(
        color: const Color(0xFF2C2C2C),
        width: 1,
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Perfectly align vertically
          children: [
            Image.asset(
              icon,
              height: 30,
              width: 30,
              fit: BoxFit.cover, // Ensures image doesn't distort
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF2C2C2C),
                height: 1.0, // Removes extra line height for perfect alignment
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