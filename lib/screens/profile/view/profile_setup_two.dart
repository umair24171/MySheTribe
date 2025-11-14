import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/screens/verifications/view/ai_tribe_matching.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class ProfileSetupTwo extends StatefulWidget {
  const ProfileSetupTwo({Key? key}) : super(key: key);

  @override
  State<ProfileSetupTwo> createState() => _ProfileSetupTwoState();
}

class _ProfileSetupTwoState extends State<ProfileSetupTwo> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _countryController = TextEditingController();
  final _languageController = TextEditingController();

  List<String> _selectedInterests = [];
  List<String> _selectedEvents = [];
  List<String> _selectedJoiningReasons = [];
  List<String> _selectedAvailability = [];

  final List<String> _interests = [
    'Culture & Heritage',
    'Entertainment & Nightlife',
    'Entrepreneurship',
    'Fitness & Wellness',
    'Lifestyle & Society',
    'Travel & Adventure',
  ];

  final List<String> _events = [
    'MyBrunchParty',
    'MyBusinessForum',
    'MyDinnerParty',
    'MyHighTea',
    'MyLadiesLunch',
    'MyWealthSummit',
  ];

  final List<String> _joiningReasons = [
    'Friendship',
    'Support',
    'Networking',
    'Relocating to UAE Dubai/ Abu Dhabi',
  ];

  final List<String> _availability = [
    'Weekends',
    'Evenings',
    'Mornings',
    'Weekdays, Mon, Tues, Wed',
  ];

  @override
  void dispose() {
    _ageController.dispose();
    _countryController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  LogoHeader(),
                  const SizedBox(height: 29),
                  Text(
                    'Profile AI Tribe Matching',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2C2C2C),
                    ),
                  ),
                  const SizedBox(height: 29),
                  Container(
                    height: 400,
                    margin: const EdgeInsets.symmetric(horizontal: 19),
                    color: Color(0xffFe9cb4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 22),
                          _buildMultiSelectField(
                            selectedItems: _selectedJoiningReasons,
                            hintText: 'Why are you joining?',
                            title: 'Why are you joining?',
                            items: _joiningReasons,
                            columns: 1,
                            onChanged: (values) {
                              setState(() {
                                _selectedJoiningReasons = values;
                              });
                            },
                          ),
                          const SizedBox(height: 22),
                          _buildMultiSelectField(
                            selectedItems: _selectedInterests,
                            hintText: 'What are your interests?',
                            title: 'What are your interests?',
                            items: _interests,
                            columns: 1,
                            onChanged: (values) {
                              setState(() {
                                _selectedInterests = values;
                              });
                            },
                          ),
                          const SizedBox(height: 22),
                          _buildMultiSelectField(
                            selectedItems: _selectedEvents,
                            hintText: 'What events do you want to attend?',
                            title: 'What events do you want to attend?',
                            items: _events,
                            columns: 2,
                            onChanged: (values) {
                              setState(() {
                                _selectedEvents = values;
                              });
                            },
                          ),
                          const SizedBox(height: 22),
                          _buildMultiSelectField(
                            selectedItems: _selectedAvailability,
                            hintText: 'When are you available for meetups?',
                            title: 'When are you available for meetups?',
                            items: _availability,
                            columns: 1,
                            onChanged: (values) {
                              setState(() {
                                _selectedAvailability = values;
                              });
                            },
                          ),
                          const SizedBox(height: 22),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 29),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainNavigationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF3A3A3A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
      ),
    );
  }

  Widget _buildMultiSelectField({
    required List<String> selectedItems,
    required String hintText,
    required String title,
    required List<String> items,
    required int columns,
    required Function(List<String>) onChanged,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: InkWell(
        onTap: () {
          _showMultiSelectDialog(
            context: context,
            title: title,
            items: items,
            selectedItems: selectedItems,
            columns: columns,
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
                  selectedItems.isEmpty ? hintText : selectedItems.join(', '),
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

  void _showMultiSelectDialog({
    required BuildContext context,
    required String title,
    required List<String> items,
    required List<String> selectedItems,
    required int columns,
    required Function(List<String>) onChanged,
  }) {
    List<String> tempSelected = List.from(selectedItems);

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
                        child: columns == 1
                            ? Column(
                                children: items.map((item) {
                                  return _buildDialogCheckboxItem(
                                    item: item,
                                    isSelected: tempSelected.contains(item),
                                    onTap: () {
                                      setState(() {
                                        if (tempSelected.contains(item)) {
                                          tempSelected.remove(item);
                                        } else {
                                          tempSelected.add(item);
                                        }
                                      });
                                    },
                                  );
                                }).toList(),
                              )
                            : _buildDialogTwoColumnLayout(
                                items: items,
                                selectedItems: tempSelected,
                                onTap: (item) {
                                  setState(() {
                                    if (tempSelected.contains(item)) {
                                      tempSelected.remove(item);
                                    } else {
                                      tempSelected.add(item);
                                    }
                                  });
                                },
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

  Widget _buildDialogTwoColumnLayout({
    required List<String> items,
    required List<String> selectedItems,
    required Function(String) onTap,
  }) {
    List<Widget> leftColumn = [];
    List<Widget> rightColumn = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final checkbox = _buildDialogCheckboxItem(
        item: item,
        isSelected: selectedItems.contains(item),
        onTap: () => onTap(item),
      );

      if (i % 2 == 0) {
        leftColumn.add(checkbox);
      } else {
        rightColumn.add(checkbox);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: leftColumn,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rightColumn,
          ),
        ),
      ],
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