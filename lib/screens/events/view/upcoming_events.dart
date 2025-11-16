import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:myshetribe/screens/events/view/event_details_screen.dart';
import 'package:myshetribe/screens/events/view/events_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';
import 'package:video_player/video_player.dart';
import 'package:myshetribe/providers/event_provider.dart';
import 'package:myshetribe/models/event_model.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({Key? key}) : super(key: key);

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    // Load events from Firebase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventProvider>(context, listen: false).loadEvents();
    });
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
        child: Consumer<EventProvider>(
          builder: (context, eventProvider, child) {
            // Get featured event and upcoming events from Firebase
            final featuredEvent = eventProvider.featuredEvent;
            final upcomingEvents = eventProvider.upcomingEvents;

            return SingleChildScrollView(
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
                  eventProvider.isLoading
                      ? Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: const Color(0xFF2C2C2C),
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : upcomingEvents.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Center(
                                child: Text(
                                  'No upcoming events',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF2C2C2C),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.symmetric(horizontal: 19),
                              padding: const EdgeInsets.all(22),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: upcomingEvents
                                      .map((event) => _buildUpcomingEventCard(event))
                                      .toList(),
                                ),
                              ),
                            ),
                  const SizedBox(height: 30),
                ],
              ),
            );
          },
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
                  // Play/Pause overlay
                  if (!_isPlaying)
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
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
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
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
        margin: const EdgeInsets.only(bottom: 22),
        height: 59,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFFE9CB4),
          borderRadius: BorderRadius.circular(0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  event.title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2C2C2C),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF2C2C2C),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
