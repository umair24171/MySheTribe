import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/screens/events/view/event_details_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';
import 'package:myshetribe/providers/event_provider.dart';
import 'package:myshetribe/providers/auth_provider.dart';
import 'package:myshetribe/models/event_model.dart';

class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({Key? key}) : super(key: key);

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final eventProvider = Provider.of<EventProvider>(context, listen: false);
      if (authProvider.currentUser != null) {
        eventProvider.loadUserEvents(authProvider.currentUser!.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
       bottomNavigationBar: CustomBottomNavBar(selectedIndex:1 ,onItemTapped: (p0) {

      },),
      body: SafeArea(
        child: Consumer<EventProvider>(
          builder: (context, eventProvider, child) {
            if (eventProvider.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: const Color(0xFF2C2C2C),
                  strokeWidth: 2,
                ),
              );
            }

            final upcomingEvents = eventProvider.userEvents;

            return SingleChildScrollView(
              child: Column(
                children: [
                const SizedBox(height: 20),
                  LogoHeader(),

                  const SizedBox(height: 20),

                  // MyEvents Title
                  Text(
                    'MyEvents',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2C2C2C),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Events List
                  if (upcomingEvents.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text(
                        'No events booked yet',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF2C2C2C),
                        ),
                      ),
                    )
                  else
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFE9CB4),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: upcomingEvents.map((event) => _buildUpcomingEventCard(event)).toList(),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
Widget _buildUpcomingEventCard(EventModel event) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailScreen(event: event),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Row(
            children: [
              // Left side - Image (45% width)
              Expanded(
                flex: 45,
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4A574),
                  ),
                  child: event.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: event.imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: const Color(0xFF2C2C2C),
                              strokeWidth: 2,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/icons/my_brunch_party.png',
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          'assets/icons/my_brunch_party.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              // Right side - Gold section with label (55% width)
              Expanded(
                flex: 55,
                child: Container(
                  height: 130,
                  color: const Color(0xFFD4A574),
                  child: Align(
                    alignment: Alignment(0, -0.99),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF000000),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Text(
                        event.title,
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.037,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFD5A472),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
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