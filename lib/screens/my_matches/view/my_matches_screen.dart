import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/match_detail_screen/view/match_detail_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';
import 'package:video_player/video_player.dart';

class MyMatchesScreen extends StatefulWidget {
  const MyMatchesScreen({Key? key}) : super(key: key);

  @override
  State<MyMatchesScreen> createState() => _MyMatchesScreenState();
}

class _MyMatchesScreenState extends State<MyMatchesScreen> {
  int _selectedIndex = 0; // My Match is selected

  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.asset('assets/video/tribe_matching.mp4')
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
          _controller.play();
          // _controller.setVolume(0);
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  final List<Map<String, dynamic>> _matches = [
    {
      'category': 'Culture Match',
      'name': 'Ashwini',
      'bio': 'Ambitious marketing professional seeking leadership opportunity',
      'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
    },
    {
      'category': 'Entertainment Match',
      'name': 'Ashwini',
      'bio': 'Ambitious marketing professional seeking leadership opportunity',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
    },
    {
      'category': 'Entrepreneurship Match',
      'name': 'Ashwini',
      'bio': 'Ambitious marketing professional seeking leadership opportunity',
      'image': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400',
    },
  ];

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFFFB6C8), // Main pink
    body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header Section (Darker Pink Background)
                  Container(
                    width: double.infinity,
                    color: const Color(0xFFFFB6C8), // Keep this darker pink
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Logo and Branding Header
                        LogoHeader(),
                        const SizedBox(height: 20),
                        // MyMatches Title
                        Text(
                          'MyTribe Matches',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                             color: Color(0xFF3A3A3A),
                          ),
                        ),
                        const SizedBox(height: 10),
                          // Welcome Video
            SizedBox(
              height: 246,
              width: double.infinity,
              child: _isVideoInitialized
                  ? FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: 246,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFCCD9),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      // child: const Center(
                      //   child: CircularProgressIndicator(
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ),
            ),
            // SizedBox(height: MediaQuery.of(context).size.width * 0.25),
                      ],
                    ),
                  ),
                  // Cards Section (Lighter Pink Background)
                  Container(
                    width: MediaQuery.of(context).size.width*0.93,
                    color: Color(0xffFe9cb4),
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: _matches.map((match) => _buildMatchCard(match)).toList(),
                    ),
                  ),
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
Widget _buildMatchCard(Map<String, dynamic> match) {
  return Container(
    margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Photo
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(match['image']),
        ),
        const SizedBox(width: 12),
        
        // Match Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Title
              Text(
                match['category'],
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C2C2C),
                ),
              ),
              const SizedBox(height: 2),
              
              // Name
              Text(
                match['name'],
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF2C2C2C),
                ),
              ),
              const SizedBox(height: 4),
              
              // Bio
              Text(
                match['bio'],
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF2C2C2C),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              
              // Buttons Row
              Row(
                children: [
                  // Yes Button
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                           _controller.pause();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MatchDetailScreen(
                                name: 'Sarah M.',
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
                          ).then((_) {
                    // Resume video when coming back
                    if (_isVideoInitialized) {
                      _controller.play();
                    }
                  });
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
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  
                  // Pass Button
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: OutlinedButton(
                        onPressed: () {
                           _controller.pause();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MatchDetailScreen(
                                name: 'Sarah M.',
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
                          ).then((_) {
                    // Resume video when coming back
                    if (_isVideoInitialized) {
                      _controller.play();
                    }
                  });
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                            color: Color(0xFF3A3A3A),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Text(
                          'Pass',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF2C2C2C),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
 
}