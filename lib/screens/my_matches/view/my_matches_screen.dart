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
    _controller = VideoPlayerController.asset('assets/video/new_tribe_matches.mp4')
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
          _controller.play();
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
                            const SizedBox(height: 10),
                            // Logo and Branding Header
                            LogoHeader(),
                            const SizedBox(height: 29),
                            // MyMatches Title
                            Text(
                              'MyTribe Matches',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                 color: Color(0xFF3A3A3A),
                              ),
                            ),
                            const SizedBox(height: 29),
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
                        margin: const EdgeInsets.symmetric(horizontal: 19),
                        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 22),
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

  return GestureDetector(
    onTap: () async {
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
    child: Container(
      height: 55,
      margin: const EdgeInsets.only(left: 0, right: 0, bottom: 22, top: 0),
      padding: const EdgeInsets.all(4),
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
                // Category and Name
                Row(
                  children: [
                    Text(
                      tribeName,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2C2C2C),
                      ),
                    ),
                    Text(
                      ' - ${(score * 100).toInt()}%',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF3A3A3A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),

                // Bio/Reason
                Text(
                  matchReasons.isNotEmpty ? matchReasons.first : 'Great match!',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF2C2C2C),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
 
}