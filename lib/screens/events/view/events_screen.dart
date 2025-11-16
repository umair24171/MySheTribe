import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
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
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 1,onItemTapped: (p0) {
        
      },),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Header with Logo
              LogoHeader(),
              const SizedBox(height: 29),
              // Events Title
              Text(
                'Events',
                style: GoogleFonts.poppins(
                   fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2C2C2C),
                ),
              ),
              const SizedBox(height: 29),
              // Featured Event Card
            _buildFeaturedEventCard(),
            const SizedBox(height: 209),
              SizedBox(
                     width: MediaQuery.of(context).size.width*0.75,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDetailScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF3A3A3A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Text(
                        'Register for Event',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

            // Container(
            //    margin: const EdgeInsets.symmetric(horizontal: 19),
            //     decoration: BoxDecoration(
            //             // color: const Color(0xFFFE9CB4),
            //             borderRadius: BorderRadius.circular(0),
            //           ),
            //   child: _buildDescriptionCard()),
                        // const SizedBox(height: 20),
                        // Upcoming Events Section
                      //   Container(
                      //           margin: const EdgeInsets.symmetric(horizontal: 19),
                      // padding: const EdgeInsets.all(22),
                      // decoration: BoxDecoration(
                      //   // color: const Color(0xFFFE9CB4),
                      //   borderRadius: BorderRadius.circular(0),
                      // ),
                      //     child: Padding(
                      //                 padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      //                 child: Column(
                      //                   crossAxisAlignment: CrossAxisAlignment.center,
                      //                   children: [
                      //                     // Text(
                      //                     //   'Upcoming Events',
                      //                     //   style: GoogleFonts.poppins(
                      //                     //     fontSize: 20,
                      //                     //     fontWeight: FontWeight.w700,
                      //                     //     color: const Color(0xFF2C2C2C),
                      //                     //   ),
                      //                     // ),
                      //                     // const SizedBox(height: 15),
                      //                     ...upcomingEvents.map((event) => _buildUpcomingEventCard(event)).toList(),
                      //                   ],
                      //                 ),
                      //     ),
                      //   ),
            
            
              const SizedBox(height: 29),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildDescriptionCard() {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 22),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: const Color(0xFFD5A472),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Text(
        'Join us for our launch High Tea at Jumeriah Al Qasr and meet your tribe. Dresscode elegant pink theme\n\n.The dress code for the event.  The menu will be and the.....',
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
          height: 265,
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
          bottom: -180  ,
          // top: 100,

          // top: 10,
          child: Center(
            child:
            _buildDescriptionCard()
          ),
        ),
      ],
    );
  }
  
}