import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
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
       bottomNavigationBar: CustomBottomNavBar(selectedIndex:0 ,onItemTapped: (p0) {
        
      },),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Logo Header
                    LogoHeader(),
                    const SizedBox(height: 20),
                    
                    // Matched Tribe Title
                    Text(
                      'MyTribe Match Profile',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2C2C2C),
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // Main Content Container - FIXED HEIGHT 360
                    Container(
                      height: 400,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFE9CB4),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Profile Row - Photo, Name, Badge
                              Row(
                                children: [
                                  // Profile Photo - Smaller
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(widget.imageUrl),
                                  ),
                                  const SizedBox(width: 10),
                                  
                                  // Name
                                  Expanded(
                                    child: Text(
                                      widget.name,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF2C2C2C),
                                      ),
                                    ),
                                  ),
                                  
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
                                        color: const Color(0xFF2C2C2C),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 10),
                              
                              // Bio
                              Text(
                                widget.bio,
                                style: GoogleFonts.poppins(
                                   fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF2C2C2C),
                                  height: 1.3,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Shared Interests
                              Text(
                                'Shared Interests',
                                style: GoogleFonts.poppins(
                                   fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF2C2C2C),
                                ),
                              ),
                              
                              const SizedBox(height: 8),
                              
                              // Interest Chips in 2 Column Grid
                              Column(
                                children: List.generate(
                                  (widget.interests.length / 2).ceil(),
                                  (rowIndex) {
                                    final startIndex = rowIndex * 2;
                                    final endIndex = (startIndex + 2) > widget.interests.length
                                        ? widget.interests.length
                                        : startIndex + 2;
                                    final rowItems = widget.interests.sublist(startIndex, endIndex);

                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Row(
                                        children: [
                                          ...rowItems.map((interest) {
                                            return Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  right: rowItems.indexOf(interest) == 0 ? 6 : 0,
                                                ),
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 0,
                                                  vertical: 8,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF3A3A3A),
                                                  borderRadius: BorderRadius.circular(0),
                                                ),
                                                child: Text(
                                                  interest,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          if (rowItems.length == 1)
                                            Expanded(child: SizedBox()),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Events She's Interested In
                              Text(
                                'Events She\'s Interested In',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF2C2C2C),
                                ),
                              ),
                              
                              const SizedBox(height: 6),
                              
                              // Events List
                              ...widget.events.map((event) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    '${event['name']} - ${event['date']}',
                                    style: GoogleFonts.poppins(
                                     fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF2C2C2C),
                                      height: 1.3,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Continue Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFF3A3A3A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
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
      // bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFFB6C8),
        unselectedItemColor: const Color(0xFFFFB6C8),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'My Match',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}