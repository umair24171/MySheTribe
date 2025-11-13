import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/authentication/view/login_screen.dart';
import 'package:myshetribe/screens/authentication/view/signup_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';
import 'package:video_player/video_player.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.asset('assets/video/new_welcome.mp4')
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
        child: Stack(
          children: [
             Padding(
               padding: const EdgeInsets.only(top: 10),
               child: Image.asset(
                    'assets/icons/Welcome_logo.png',
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
             ),
            Column(
              children: [
                const SizedBox(height: 205),
                // Header Logo
               
            
                // Welcome Title
                Text(
                  'Welcome to your tribe',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2C2C2C),
                  ),
                ),
            
                const SizedBox(height: 29),
            
                // Welcome Video with Play/Pause Button
                SizedBox(
                  height: 246,
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
                                  height: 246,
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
                          height: 246,
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
                ),
                SizedBox(height: 29),
                // Get Started Button
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      _controller.pause();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen())).then((_) {
                        // Don't resume video when coming back
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFFFB6F92),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            
                SizedBox(height: 29),
            
                // Login Button
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      _controller.pause();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen())).then((_) {
                        // Don't resume video when coming back
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
                      'Login',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}