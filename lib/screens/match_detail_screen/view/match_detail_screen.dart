import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/screens/main_chat_lounge/view/chats_screen.dart';
import 'package:myshetribe/screens/match_detail_screen/view/match_detail_two.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class MatchDetailScreen extends StatefulWidget {
  final String name;
  final String imageUrl;
  final int matchPercentage;
  final String bio;
  final List<String> interests;
  final List<Map<String, String>> events;

  const MatchDetailScreen({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.matchPercentage,
    required this.bio,
    required this.interests,
    required this.events,
  }) : super(key: key);

  @override
  State<MatchDetailScreen> createState() => _MatchDetailScreenState();
}

class _MatchDetailScreenState extends State<MatchDetailScreen> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 0,
        onItemTapped: (p0) {},
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    // Logo Header
                    LogoHeader(),
                    const SizedBox(height: 29),
                    
                    // Matched Tribe Title
                    Text(
                      'MyTribe Match Profile',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2C2C2C),
                      ),
                    ),
                    
                    const SizedBox(height: 29),
                    
                    // Main Content Container
                    Container(
                      // height: 400,
                        margin: const EdgeInsets.symmetric(horizontal: 19),
                    padding: const EdgeInsets.all(22),
                    // decoration: BoxDecoration(
                    //   color: const Color(0xFFFE9CB4),
                    //   borderRadius: BorderRadius.circular(0),
                    // ),
                      color: Colors.white,
                      // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Row - Photo, Name, Badge
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Profile Photo
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(widget.imageUrl),
                              ),
                              const SizedBox(width: 10),
                              
                              // Name
                      Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        '${widget.name}',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF2C2C2C),
        ),
      ),
      Text(
        '${' ' * ((widget.name.length)/2).floor()}Sarah M.',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF2C2C2C),
        ),
      ),
    ],
  ),
),
                              // Spacer(),
                              // Percentage Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD5A472),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${widget.matchPercentage}%',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color:  Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 10),
                          
                          // Bio - No maxLines, full text
                          Text(
                            'Friendly and adventurous, loves meeting new people and trying new activities.  She is a Doctor and has been in UAE ........she loves travelling, dining out, yoga, and active sports. Married',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF2C2C2C),
                              height: 1.3,
                            ),
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Shared Interests
                          Text(
                            'Shared Interests',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2C2C2C),
                            ),
                          ),
                          
                          const SizedBox(height: 4),
                          
                          // Interests as pink comma-separated text
                          Text(
                            widget.interests.join(', '),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFFB6F92),
                              height: 1.3,
                            ),
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Events She's Interested In
                          Text(
                            'Events She\'s Interested In',
                            style: GoogleFonts.poppins(
                            fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2C2C2C),
                            ),
                          ),
                          
                          const SizedBox(height: 4),
                          
                          // Events as pink comma-separated text
                          Text(
                            widget.events.map((e) => e['name']).join(', '),
                           style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFFB6F92),
                              height: 1.3,
                            ),
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Available for meet ups
                          Text(
                            'Available for meet ups:',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2C2C2C),
                            ),
                          ),
                          
                          const SizedBox(height: 4),
                          
                          Text(
                            'Weekends - Saturday & Sunday',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFFB6F92),
                              height: 1.3,
                            ),
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Is this a match?
                          Text(
                            'Is this a match?',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2C2C2C),
                            ),
                          ),
                          
                          const SizedBox(height: 22),
                          
                          // Three buttons row
                          Row(
                            children: [
                              // Yes Button
                              Expanded(
                                child: SizedBox(
                                  height: 25,
                                  child: ElevatedButton(
                                    onPressed: () {
                                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MatchDetailTwo(
                                  name: widget.name,
                                  imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
                                  matchPercentage: 82,
                                  bio: 'Friendly and adventurous, LOves meeting new people and trying new activities.',
                                  interests: ['Culture', 'Fitness', 'Travel', 'Entertainment'],
                                  events: [
                                    {'name': 'MyShe Brunch', 'date': 'Nov 20'},
                                    {'name': 'Yoga in the Park', 'date': 'Nov 26'},
                                    {'name': 'Dubai Art Festival', 'date': 'Dec 1'},
                                  ],
                                ),
                              ),
                            );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: const Color(0xFF3A3A3A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                    ),
                                    child: Text(
                                      'Yes',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              
                              // Pass Button
                              Expanded(
                                child: SizedBox(
                                  height: 25,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Color(0xFF3A3A3A),
                                        width: 1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                    ),
                                    child: Text(
                                      'Pass',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF3A3A3A),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              
                              // Chat Button
                              Expanded(
                                child: SizedBox(
                                  height: 25,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatLoungeScreen(chatName: 'Sarah', profileImage: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400')));
                                   
                                    },
                                    style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                        color: Color(0xFF3A3A3A),
                                        width: 1,
                                      ),
                                      elevation: 0,
                                      backgroundColor: const Color(0xFFFF9AB4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                    ),
                                    child: Text(
                                      'Chat',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 22),
                          
                          // // Next Button
                          // SizedBox(
                          //   width: double.infinity,
                          //   height: 55  ,
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       Navigator.pop(context);
                          //     },
                          //     style: ElevatedButton.styleFrom(
                          //       elevation: 0,
                          //       backgroundColor: const Color(0xFF3A3A3A),
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(0),
                          //       ),
                          //     ),
                          //     child: Text(
                          //       'Next',
                          //       style: GoogleFonts.poppins(
                          //         fontSize: 15,
                          //         fontWeight: FontWeight.w600,
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
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
}