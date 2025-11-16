import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/about/view/thank_you_screen.dart';
import 'package:myshetribe/screens/about/view/your_plans.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class WhatAreYourPlansScreen extends StatefulWidget {
  const WhatAreYourPlansScreen({Key? key}) : super(key: key);

  @override
  State<WhatAreYourPlansScreen> createState() => _WhatAreYourPlansScreenState();
}

class _WhatAreYourPlansScreenState extends State<WhatAreYourPlansScreen> {
  DateTime? _selectedRelocatingDate;
  String? _selectedVisaApplied;
  String? _selectedVisaType;
  String? _selectedVisaInfo;
  String? _selectedSupport;
  String? _selectedBuddy;
  String? _selectedRelocatingWith;
  String? _selectedUAEEmirate;
  
  final List<String> _uaeEmirates = [
    'Abu Dhabi',
    'Dubai',
    'Sharjah',
    'Ajman',
    'Umm Al Quwain',
    'Ras Al Khaimah',
    'Fujairah',
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

  final List<String> _relocatingWith = [
    'Alone',
    'Partner',
    'Family',
    'Friends',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedRelocatingDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFFFF9AB4),
              onPrimary: Colors.white,
              onSurface: const Color(0xFF2C2C2C),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedRelocatingDate) {
      setState(() {
        _selectedRelocatingDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2,
        onItemTapped: (p0) {},
      ),
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
                  color: const Color(0xFF3A3A3A),
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
                      const SizedBox(height: 22),
                      // Who are you relocating with?
                      _buildSingleSelectField(
                        selectedItem: _selectedRelocatingWith,
                        hintText: 'Who are you relocating with?',
                        title: 'Who are you relocating with?',
                        items: _relocatingWith,
                        onChanged: (value) {
                          setState(() {
                            _selectedRelocatingWith = value;
                          });
                        },
                      ),
                      const SizedBox(height: 22),
                      
                      // Which UAE Emirate are you relocating to?
                      _buildSingleSelectField(
                        selectedItem: _selectedUAEEmirate,
                        hintText: 'Which UAE Emirate are you relocating to?',
                        title: 'Which UAE Emirate are you relocating to?',
                        items: _uaeEmirates,
                        onChanged: (value) {
                          setState(() {
                            _selectedUAEEmirate = value;
                          });
                        },
                      ),
                      const SizedBox(height: 22),
                      
                      // Date when are you planning to relocating? - CALENDAR
                      _buildDatePickerField(),
                      const SizedBox(height: 22),

                      // Have you applied for your visa?
                      _buildSingleSelectField(
                        selectedItem: _selectedVisaApplied,
                        hintText: 'Have you applied for your visa?',
                        title: 'Have you applied for your visa?',
                        items: _yesNoOptions,
                        onChanged: (value) {
                          setState(() {
                            _selectedVisaApplied = value;
                          });
                        },
                      ),
                      const SizedBox(height: 22),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 29),

              // Submit Button
              Padding(
                padding: const EdgeInsets.only(right: 22),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 61,
                    height: 23,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => YourPlans(),
                          ),
                        );
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
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerField() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: InkWell(
        onTap: () => _selectDate(context),
        child: Container(
          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _selectedRelocatingDate != null
                      ? _formatDate(_selectedRelocatingDate!)
                      : 'Date when are you planning to relocating?',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2C2C2C),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.calendar_today,
                color: const Color(0xFF2C2C2C),
                size: 20,
              ),
            ],
          ),
        ),
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