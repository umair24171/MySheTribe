import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/events/view/event_details_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final Map<String, dynamic> featuredEvent = {
    'title': 'MyHighTea',
    'date': '13 December 2025',
    'description':
        'Join us for our launch High Tea at Jumeriah Al Qasr and meet your tribe. Dresscode elegant pink theme.',
    'image': 'assets/icons/my_events_header_pic.png',
  };

  final List<Map<String, dynamic>> upcomingEvents = [
    {
      'title': 'MyBrunchParty',
      'image': 'assets/icons/my_brunch_party.png',
    },
    {
      'title': 'MyDinnerParty',
      'image': 'assets/icons/my_dinner_party.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Header with Logo
              LogoHeader(),
              const SizedBox(height: 20),
              // Events Title
              Text(
                'Events',
                style: GoogleFonts.poppins(
                   fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2C2C2C),
                ),
              ),
              const SizedBox(height: 10),
              // Featured Event Card
            _buildFeaturedEventCard(),
            Container(
               margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                        color: const Color(0xFFFE9CB4),
                        borderRadius: BorderRadius.circular(0),
                      ),
              child: _buildDescriptionCard()),
                        // const SizedBox(height: 20),
                        // Upcoming Events Section
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
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildDescriptionCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFD5A472),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Text(
        featuredEvent['description'],
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF2C2C2C),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }


 

  Widget _buildFeaturedEventCard() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Event Image
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(featuredEvent['image']),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Overlapping Gold Box with Title and Date
        Positioned(
           left: 0,
        right: 0,
          bottom: 0,
          child: Center(
            child: Container(
                alignment: Alignment
                .center,
               width: MediaQuery.of(context).size.width*0.7,
               height: 57,
              // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFD5A472),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    featuredEvent['title'],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2C2C2C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // const SizedBox(height: 6),
                  Text(
                    featuredEvent['date'],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2C2C2C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
                    image: DecorationImage(
                      image: AssetImage(event['image']),
                      fit: BoxFit.cover,
                    ),
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
                        event['title'],
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