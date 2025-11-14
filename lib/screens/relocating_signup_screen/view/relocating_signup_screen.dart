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
                color: const Color(0xFF3A3A3A),
              ),
            ),

            const SizedBox(height: 29),

            // Main Content Container
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Video Section
                      SizedBox(
                        height: 248,
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

                      // Form Fields Container
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 19),
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFE9CB4),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
                          child: Column(
                            children: [
                              const SizedBox(height: 22),
                              // Why are you relocating?
                              _buildSingleSelectField(
                                selectedItem: _selectedRelocatingReason,
                                hintText: 'Why are you relocating?',
                                title: 'Why are you relocating?',
                                items: _relocatingReasons,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRelocatingReason = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 22),

                              // Which country are relocating from?
                              _buildSingleSelectField(
                                selectedItem: _selectedCountryFrom,
                                hintText: 'Which country are relocating from?',
                                title: 'Which country are relocating from?',
                                items: _countriesFrom,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCountryFrom = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 22),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 29),

                      // Next Button
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            _controller.pause();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WhatAreYourPlansScreen(),
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
                            backgroundColor: Color(0xff3A3A3A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: Text(
                            'Submit',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2,
        onItemTapped: (p0) {},
      ),
    );
  }

  Widget _buildSingleSelectField({
    required String? selectedItem,
    required String hintText,
    required String title,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: InkWell(
        onTap: () {
          _showSingleSelectDialog(
            context: context,
            title: title,
            items: items,
            selectedItem: selectedItem,
            onChanged: onChanged,
          );
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  selectedItem ?? hintText,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2C2C2C),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: const Color(0xFF2C2C2C),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSingleSelectDialog({
    required BuildContext context,
    required String title,
    required List<String> items,
    required String? selectedItem,
    required Function(String?) onChanged,
  }) {
    String? tempSelected = selectedItem;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2C2C2C),
                        ),
                      ),
                    ),
                    
                    // Items List
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: items.map((item) {
                            return _buildDialogCheckboxItem(
                              item: item,
                              isSelected: tempSelected == item,
                              onTap: () {
                                setState(() {
                                  tempSelected = item;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    
                    // Buttons
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF2C2C2C),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                onChanged(tempSelected);
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2C2C2C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: Text(
                                'Done',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDialogCheckboxItem({
    required String item,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF2C2C2C),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFF2C2C2C),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 14,
                      color: const Color(0xFF2C2C2C),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}