import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/about/view/thank_you_screen.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class YourPlans extends StatefulWidget {
  const YourPlans({Key? key}) : super(key: key);

  @override
  State<YourPlans> createState() => _YourPlansState();
}

class _YourPlansState extends State<YourPlans> {
  String? _selectedVisaType;
  String? _selectedVisaInfo;
  String? _selectedSupport;
  String? _selectedBuddy;

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
                margin: const EdgeInsets.symmetric(horizontal: 19),
                decoration: BoxDecoration(
                  color: const Color(0xFFFE9CB4),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // If Yes which visa do you hold?
                      _buildSingleSelectField(
                        selectedItem: _selectedVisaType,
                        hintText: 'If Yes which visa do you hold?',
                        title: 'If Yes which visa do you hold?',
                        items: _visaTypes,
                        onChanged: (value) {
                          setState(() {
                            _selectedVisaType = value;
                          });
                        },
                      ),
                      const SizedBox(height: 22),

                      // If No do you require info about visa options
                      _buildSingleSelectField(
                        selectedItem: _selectedVisaInfo,
                        hintText: 'If No do you require info about visa options',
                        title: 'If No do you require info about visa options',
                        items: _yesNoOptions,
                        onChanged: (value) {
                          setState(() {
                            _selectedVisaInfo = value;
                          });
                        },
                      ),
                      const SizedBox(height: 22),

                      // What support do you require?
                      _buildSingleSelectField(
                        selectedItem: _selectedSupport,
                        hintText: 'What support do you require?',
                        title: 'What support do you require?',
                        items: _supportOptions,
                        onChanged: (value) {
                          setState(() {
                            _selectedSupport = value;
                          });
                        },
                      ),
                      const SizedBox(height: 22),

                      // Would you like to be paired with a buddy?
                      _buildSingleSelectField(
                        selectedItem: _selectedBuddy,
                        hintText: 'Would you like to be paired with a buddy?',
                        title: 'Would you like to be paired with a buddy?',
                        items: _yesNoOptions,
                        onChanged: (value) {
                          setState(() {
                            _selectedBuddy = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 29),

              // Submit Button
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThankYouScreen(),
                      ),
                    );
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