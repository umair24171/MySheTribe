import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myshetribe/screens/match_detail_screen/view/match_detail_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';
import 'package:myshetribe/providers/user_provider.dart';
import 'package:myshetribe/providers/auth_provider.dart';
import 'package:myshetribe/providers/tribe_provider.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (authProvider.currentUser != null) {
        userProvider.loadUser(authProvider.currentUser!.uid);
      }
    });
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


 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFFFB6C8), // Main pink
    body: SafeArea(
      child: Consumer2<UserProvider, TribeProvider>(
        builder: (context, userProvider, tribeProvider, child) {
          final userRecommendations = userProvider.user?.recommendations ?? [];

          return Column(
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
                        ),
                ),
                          ],
                        ),
                      ),
                      // Cards Section (Lighter Pink Background)
                      Container(
                        width: MediaQuery.of(context).size.width*0.93,
                        color: Color(0xffFe9cb4),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: userProvider.isLoading
                            ? Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: const Color(0xFF2C2C2C),
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : userRecommendations.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(40.0),
                                    child: Text(
                                      'No tribe matches yet. Complete your profile to get AI recommendations!',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF2C2C2C),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : Column(
                                    children: userRecommendations.map((recommendation) => _buildMatchCard(recommendation, tribeProvider)).toList(),
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
    // bottomNavigationBar: _buildBottomNavBar(),
  );
}
Widget _buildMatchCard(dynamic recommendation, TribeProvider tribeProvider) {
  // recommendation is a TribeRecommendation from the user model
  final tribeName = recommendation.tribeName;
  final score = recommendation.score;
  final matchReasons = recommendation.matchReasons;
  final tribeId = recommendation.tribeId;

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
        // Tribe Icon
        CircleAvatar(
          radius: 35,
          backgroundColor: const Color(0xFFFFB6C8),
          child: Icon(
            Icons.groups,
            size: 35,
            color: const Color(0xFF3A3A3A),
          ),
        ),
        const SizedBox(width: 12),

        // Match Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tribe Name
              Text(
                tribeName,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C2C2C),
                ),
              ),
              const SizedBox(height: 2),

              // Match Score
              Text(
                '${(score * 100).toInt()}% Match',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF2C2C2C),
                ),
              ),
              const SizedBox(height: 4),

              // Match Reasons
              Text(
                matchReasons.isNotEmpty ? matchReasons.first : 'Great match!',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF2C2C2C),
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              // Buttons Row
              Row(
                children: [
                  // View Details Button
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          _controller.pause();
                          // Load tribe details
                          final tribe = await tribeProvider.getTribeById(tribeId);
                          if (tribe != null && context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MatchDetailScreen(
                                  name: tribe.name,
                                  imageUrl: tribe.imageUrl ?? '',
                                  matchPercentage: (score * 100).toInt(),
                                  bio: tribe.description,
                                  interests: tribe.interests,
                                  events: [], // Could load tribe events here
                                ),
                              ),
                            ).then((_) {
                              if (_isVideoInitialized) {
                                _controller.play();
                              }
                            });
                          } else {
                            _controller.play();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFF3A3A3A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Text(
                          'View',
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
                          // Could implement pass functionality here
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