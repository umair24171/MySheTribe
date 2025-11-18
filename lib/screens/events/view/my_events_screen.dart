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
  final List<Map<String, dynamic>> upcomingEvents = [
    {
      'title': 'MyBrunchParty',
      'image': 'assets/icons/my_brunch_party.png',
    },
    {
      'title': 'MyBusiness Forum',
      'image': 'assets/icons/my_dinner_party.png',
    },
    {
      'title': 'MyDinnerParty',
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
    // {
    //   'title': 'MyWealthSummit',
    //   'image': 'assets/icons/my_dinner_party.png',
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1,
        onItemTapped: (p0) {},
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              LogoHeader(),
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

              // Events List with ListView.builder
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: upcomingEvents.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return Center(
                    child: _buildUpcomingEventCard(upcomingEvents[index]),
                  );
                },
              ),

              const SizedBox(height: 30),
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
        margin: const EdgeInsets.only(bottom: 22,left: 22+19,right: 22+19),
        height: 59,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Left side - Image
            Container(
              height: 59,
              width: 98,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(event['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Right side - Gold section
            Container(
              height: 98,
              width: MediaQuery.of(context).size.width -98-22-22-19-19 ,

              color: const Color(0xFFD4A574),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 28,
                    width: 154,
                    color: const Color(0xFF000000),
                    alignment: Alignment.center,
                    child: Text(
                      event['title'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFD5A472),
                      ),
                    ),
                  ),
                  // Text(
                  //   '14 February 2026',
                  //   style: GoogleFonts.poppins(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w500,
                  //     color: const Color(0xFF3A3A3A),
                  //   ),
                  // ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
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
      size.width * 0.2,
      size.height * 0.1,
      size.width * 0.1,
      size.height * 0.4,
      size.width * 0.5,
      size.height * 0.8,
    );
    path.cubicTo(
      size.width * 0.9,
      size.height * 0.4,
      size.width * 0.8,
      size.height * 0.1,
      size.width * 0.5,
      size.height * 0.3,
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