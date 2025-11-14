import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:myshetribe/screens/about/view/thank_you_screen.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/widgets/logo_header.dart';
import 'package:myshetribe/providers/user_provider.dart';
import 'package:myshetribe/providers/auth_provider.dart';
import 'package:myshetribe/models/user_model.dart';

class WhatAreYourPlansScreen extends StatefulWidget {
  final String relocatingReason;
  final String relocatingWith;
  final String countryFrom;
  final String uaeEmirate;

  const WhatAreYourPlansScreen({
    Key? key,
    required this.relocatingReason,
    required this.relocatingWith,
    required this.countryFrom,
    required this.uaeEmirate,
  }) : super(key: key);

  @override
  State<WhatAreYourPlansScreen> createState() => _WhatAreYourPlansScreenState();
}

class _WhatAreYourPlansScreenState extends State<WhatAreYourPlansScreen> {
  String? _selectedRelocatingDate;
  String? _selectedVisaApplied;
  String? _selectedVisaType;
  String? _selectedVisaInfo;
  String? _selectedSupport;
  String? _selectedBuddy;
  bool _isProcessing = false;

  final List<String> _relocatingDates = [
    'Within 1 month',
    '1-3 months',
    '3-6 months',
    '6-12 months',
    'More than 1 year',
    'Not sure yet',
  ];

  final List<String> _yesNoOptions = [
    'Yes',
    'No',
  ];

  final List<String> _visaTypes = [
    'Employment Visa',
    'Investor Visa',
    'Partner Visa',
    'Retirement Visa',
    'Student Visa',
    'Tourist Visa',
    'Other',
  ];

  final List<String> _supportOptions = [
    'Housing/Accommodation',
    'Job Search',
    'School/Education',
    'Legal/Documentation',
    'Community/Networking',
    'All of the above',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: CustomBottomNavBar(selectedIndex:2 ,onItemTapped: (p0) {
        
      },),
      backgroundColor: const Color(0xFFFFB6C8),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              LogoHeader(),
              const SizedBox(height: 29),

              // Title
              Text(
                'What are your plans',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2C2C2C),
                ),
              ),

              const SizedBox(height: 29),

              // Main Content Container
              Container(
                height: 400,
                margin: const EdgeInsets.symmetric(horizontal: 19),
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFE9CB4),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
                  child: Column(
                    children: [
                    // Date when are you planning to relocating?
                    _buildDropdownField(
                      hint: 'Date when are you planning to relocating?',
                      value: _selectedRelocatingDate,
                      items: _relocatingDates,
                      onChanged: (value) {
                        setState(() {
                          _selectedRelocatingDate = value;
                        });
                      },
                    ),
                    const SizedBox(height: 22),
              
                    // Have you applied for your visa?
                    _buildDropdownField(
                      hint: 'Have you applied for your visa?',
                      value: _selectedVisaApplied,
                      items: _yesNoOptions,
                      onChanged: (value) {
                        setState(() {
                          _selectedVisaApplied = value;
                        });
                      },
                    ),
                    const SizedBox(height: 22),
              
                    // If Yes which visa do you hold if YES?
                    _buildDropdownField(
                      hint: 'If Yes which visa do you hold if YES?',
                      value: _selectedVisaType,
                      items: _visaTypes,
                      onChanged: (value) {
                        setState(() {
                          _selectedVisaType = value;
                        });
                      },
                    ),
                    const SizedBox(height: 22),
              
                    // If No do you require info about visa options
                    _buildDropdownField(
                      hint: 'If No do you require info about visa options',
                      value: _selectedVisaInfo,
                      items: _yesNoOptions,
                      onChanged: (value) {
                        setState(() {
                          _selectedVisaInfo = value;
                        });
                      },
                    ),
                    const SizedBox(height: 22),
              
                    // What support do you require?
                    _buildDropdownField(
                      hint: 'What support do you require?',
                      value: _selectedSupport,
                      items: _supportOptions,
                      onChanged: (value) {
                        setState(() {
                          _selectedSupport = value;
                        });
                      },
                    ),
                    const SizedBox(height: 22),
              
                    // Would you like to paired with a buddy?
                    _buildDropdownField(
                      hint: 'Would you like to paired with a buddy?',
                      value: _selectedBuddy,
                      items: _yesNoOptions,
                      onChanged: (value) {
                        setState(() {
                          _selectedBuddy = value;
                        });
                      },
                    ),
                   
                    // const SizedBox(height: 30),
                  ],
                ),
              ),
                          ),
                           const SizedBox(height: 30),
              
                    // Submit Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _isProcessing ? null : () async {
                          // Validate that all fields are filled
                          if (_selectedRelocatingDate == null ||
                              _selectedVisaApplied == null ||
                              _selectedVisaType == null ||
                              _selectedVisaInfo == null ||
                              _selectedSupport == null ||
                              _selectedBuddy == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please fill all fields'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          setState(() {
                            _isProcessing = true;
                          });

                          final authProvider = Provider.of<AuthProvider>(context, listen: false);
                          final userProvider = Provider.of<UserProvider>(context, listen: false);

                          if (authProvider.currentUser == null) {
                            setState(() {
                              _isProcessing = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please login to continue'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          // Create relocation info object
                          final relocationInfo = RelocationInfo(
                            relocatingReason: widget.relocatingReason,
                            relocatingWith: widget.relocatingWith,
                            countryFrom: widget.countryFrom,
                            uaeEmirate: widget.uaeEmirate,
                            relocatingDate: _selectedRelocatingDate,
                            visaApplied: _selectedVisaApplied,
                            visaType: _selectedVisaType,
                            visaInfo: _selectedVisaInfo,
                            support: _selectedSupport,
                            buddy: _selectedBuddy,
                          );

                          // Save to Firebase
                          bool success = await userProvider.updateRelocationInfo(relocationInfo);

                          setState(() {
                            _isProcessing = false;
                          });

                          if (success && mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ThankYouScreen(),
                              ),
                            );
                          } else if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to save relocation information'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.black,
                          disabledBackgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: _isProcessing
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Submit',
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
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2C2C2C),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
        ),
        style: GoogleFonts.poppins(
         fontSize: MediaQuery.of(context).size.width*0.03,
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