import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/events/view/event_details_screen.dart';
import 'package:myshetribe/screens/events/view/events_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';
import 'package:video_player/video_player.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({Key? key}) : super(key: key);

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;
  bool _isPlaying = false;

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
     {
      'title': 'MyDinnerParty',
      'image': 'assets/icons/my_dinner_party.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.asset('assets/video/Events_video.mp4')
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
          _controller.setLooping(true);
        });
      });
    
    // Listen to video state changes
    _controller.addListener(() {
      if (_controller.value.isPlaying != _isPlaying) {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      }
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
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
      backgroundColor: const Color(0xFFFFB6C8),
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
                'Upcoming Events',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2C2C2C),
                ),
              ),
              const SizedBox(height: 29),
              // Featured Event Card with Video
              _buildFeaturedEventCard(),
              const SizedBox(height: 0),
          
              // Upcoming Events Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 19),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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

  Widget _buildFeaturedEventCard() {
    return SizedBox(
      height: 247,
      width: double.infinity,
      child: _isVideoInitialized
          ? GestureDetector(
              onTap: _togglePlayPause,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRect(
                    child: SizedBox(
                      width: double.infinity,
                      height: 247,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _controller.value.size.width,
                          height: _controller.value.size.height,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                  ),
                  // Play/Pause Button Overlay
                  AnimatedOpacity(
                    opacity: !_isPlaying ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              width: double.infinity,
              height: 247,
              decoration: BoxDecoration(
                color: const Color(0xFFFFCCD9),
                borderRadius: BorderRadius.circular(0),
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
            builder: (context) => EventsScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 22),
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Row(
            children: [
              // Left side - Image (45% width)
              Container(
                height: 55,
                width: 98,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(event['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Right side - Gold section with label (55% width)
              Container(
                height: 98,
                width: MediaQuery.of(context).size.width * 0.5,
                color: const Color(0xFFD4A574),
                child: Align(
                  alignment: Alignment(0.7, -0.99),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 28,
                        width: 154,
                        decoration: BoxDecoration(
                          color: const Color(0xFF000000),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Text(
                          event['title'],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFD5A472),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        '14 February 2026',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF3A3A3A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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