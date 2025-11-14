import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/about/view/tell_us_about_screen.dart';
import 'package:myshetribe/screens/about/view/your_uae_plans.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/widgets/logo_header.dart';
import 'package:video_player/video_player.dart';

class RelocatingSignUpScreen extends StatefulWidget {
  const RelocatingSignUpScreen({Key? key}) : super(key: key);

  @override
  State<RelocatingSignUpScreen> createState() => _RelocatingSignUpScreenState();
}

class _RelocatingSignUpScreenState extends State<RelocatingSignUpScreen> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;

  String? _selectedRelocatingReason;
  String? _selectedRelocatingWith;
  String? _selectedCountryFrom;
  String? _selectedUAEEmirate;

  final List<String> _relocatingReasons = [
    'Work/Career',
    'Family',
    'Education',
    'Lifestyle',
    'Business',
    'Other',
  ];

  final List<String> _relocatingWith = [
    'Alone',
    'Partner',
    'Family',
    'Friends',
  ];

  final List<String> _countriesFrom = [
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'India',
    'Pakistan',
    'Philippines',
    'South Africa',
    'Other',
  ];

  final List<String> _uaeEmirates = [
    'Abu Dhabi',
    'Dubai',
    'Sharjah',
    'Ajman',
    'Umm Al Quwain',
    'Ras Al Khaimah',
    'Fujairah',
  ];

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.asset('assets/video/relocating_video.mp4')
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
     backgroundColor: const Color(0xFFFFB6C8),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            LogoHeader(),
            const SizedBox(height: 29),

            // Title
            Text(
              'Relocating Registration',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2C2C2C),
              ),
            ),

            const SizedBox(height: 29),

            // Main Content Container
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  // color: const Color(0xFFFE9CB4),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Video Section
                      SizedBox(
                        height: 300,
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
                                height: 300,
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

                      const SizedBox(height: 30),

                      // Form Fields Container
                     Container(
                      height: 400,
                      margin: const EdgeInsets.symmetric(horizontal: 19),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFE9CB4),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Container(
                        // color: Colors.white,
                       margin: const EdgeInsets.symmetric(horizontal: 0),
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
                          child: Column(
                            children: [
                              // Why are you relocating?
                              _buildDropdownField(
                                hint: 'Why are you relocating?',
                                value: _selectedRelocatingReason,
                                items: _relocatingReasons,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRelocatingReason = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 22),

                              // Who are you relocating with?
                              _buildDropdownField(
                                hint: 'Who are you relocating with?',
                                value: _selectedRelocatingWith,
                                items: _relocatingWith,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRelocatingWith = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 22),

                              // Which country are relocating from?
                              _buildDropdownField(
                                hint: 'Which country are relocating from?',
                                value: _selectedCountryFrom,
                                items: _countriesFrom,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCountryFrom = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 22),
                        
                              // Which UAE Emirate are you relocating to?
                              _buildDropdownField(
                                hint: 'Which UAE Emirate are you relocating to?',
                                value: _selectedUAEEmirate,
                                items: _uaeEmirates,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedUAEEmirate = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 40),
                        
                              // Next Button
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Validate that all fields are filled
                                    if (_selectedRelocatingReason == null ||
                                        _selectedRelocatingWith == null ||
                                        _selectedCountryFrom == null ||
                                        _selectedUAEEmirate == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Please fill all fields'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    _controller.pause();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WhatAreYourPlansScreen(
                                          relocatingReason: _selectedRelocatingReason!,
                                          relocatingWith: _selectedRelocatingWith!,
                                          countryFrom: _selectedCountryFrom!,
                                          uaeEmirate: _selectedUAEEmirate!,
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
                                    backgroundColor:  Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                  child: Text(
                                    'Next',
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
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex:2 ,onItemTapped: (p0) {
        
      },),
    );
  }

  Widget _buildDropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: DropdownButtonFormField<String>(
        
        value: value,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.width*0.03,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2C2C2C),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 0,
          ),
        ),
        style: GoogleFonts.poppins(
          fontSize:  MediaQuery.of(context).size.width*0.03,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF2C2C2C),
        ),
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Color(0xFF2C2C2C),
        ),
        dropdownColor: Colors.white,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}