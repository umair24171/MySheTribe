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
  bool _isPlaying = false;

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
    'Africa',
    'Americas',
    'Asia',
    'Australia & New Zealand',
    'Europe',
    'Middle East',
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
    _controller = VideoPlayerController.asset('assets/video/new_relocating.mp4')
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
                      // Video Section with Play/Pause
                      SizedBox(
                        height: 248,
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
                                        height: 248,
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
                                height: 248,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFCCD9),
                                  borderRadius: BorderRadius.circular(0),
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
                                hintText: 'What continent are you relocating from?',
                                title: 'What continent are you relocating from?',
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
                      Padding(
                        padding: const EdgeInsets.only(right: 22),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: 61,
                            height: 23,
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
                                padding: EdgeInsets.all(0),
                                elevation: 0,
                                backgroundColor: Color(0xff3A3A3A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              child: Text(
                                'Next',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
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
    TextEditingController otherController = TextEditingController();

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
                            return Column(
                              children: [
                                _buildDialogCheckboxItem(
                                  item: item,
                                  isSelected: tempSelected == item,
                                  onTap: () {
                                    setState(() {
                                      tempSelected = item;
                                    });
                                  },
                                ),
                                // Show TextField next to "Other" when selected
                                if (item == 'Other' && tempSelected == 'Other')
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                                    child: Container(
                                      height: 55,
                                      child: TextField(
                                        controller: otherController,
                                        decoration: InputDecoration(
                                          hintText: 'Please specify',
                                          hintStyle: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(0),
                                            borderSide: BorderSide(
                                              color: const Color(0xFF2C2C2C),
                                              width: 1,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(0),
                                            borderSide: BorderSide(
                                              color: const Color(0xFF2C2C2C),
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(0),
                                            borderSide: BorderSide(
                                              color: const Color(0xFF2C2C2C),
                                              width: 2,
                                            ),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 16,
                                          ),
                                        ),
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF2C2C2C),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
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
                                // If "Other" is selected and text is entered, use the custom text
                                if (tempSelected == 'Other' && otherController.text.isNotEmpty) {
                                  onChanged(otherController.text);
                                } else {
                                  onChanged(tempSelected);
                                }
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