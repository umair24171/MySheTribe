import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:myshetribe/screens/verifications/view/ai_tribe_matching.dart';
import 'package:myshetribe/widgets/logo_header.dart';
import 'package:myshetribe/providers/user_provider.dart';
import 'package:myshetribe/providers/auth_provider.dart';

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
                    'Profile Set Up AI Tribe Matching',
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
                            items: _joiningReasons,
                            columns: 1,
                          ),
                          const SizedBox(height: 22),
                          _buildMultiSelectField(
                            selectedItems: _selectedInterests,
                            hintText: 'Select your interest?',
                            items: _interests,
                            columns: 1,
                          ),
                          const SizedBox(height: 22),
                          _buildMultiSelectField(
                            selectedItems: _selectedEvents,
                            hintText: 'Select events you want to attend?',
                            items: _events,
                            columns: 2,
                          ),
                          const SizedBox(height: 22),
                          _buildMultiSelectField(
                            selectedItems: _selectedAvailability,
                            hintText: 'When are you available for meetups?',
                            items: _availability,
                            columns: 1,
                          ),
                          const SizedBox(height: 22),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 29),
                  Consumer2<UserProvider, AuthProvider>(
                    builder: (context, userProvider, authProvider, child) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: userProvider.isLoading ? null : () async {
                            if (_formKey.currentState!.validate()) {
                              // Combine all interests for AI matching
                              List<String> allInterests = [
                                ..._selectedInterests,
                                ..._selectedEvents,
                                ..._selectedJoiningReasons,
                              ];

                              bool success = await userProvider.updateProfile(
                                interests: allInterests,
                              );

                              if (success) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AITribeMatchingScreen(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(userProvider.errorMessage ?? 'Failed to save profile'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xFF3A3A3A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: userProvider.isLoading
                              ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                              : Text(
                                  'Save',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    },
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
    required List<String> items,
    required int columns,
  }) {
    final fieldKey = GlobalKey();

    return Container(
      key: fieldKey,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: InkWell(
        onTap: () {
          _showMultiSelectDropdown(
            context: context,
            fieldKey: fieldKey,
            items: items,
            selectedItems: selectedItems,
            columns: columns,
            onSelectionChanged: (List<String> selected) {
              setState(() {
                selectedItems.clear();
                selectedItems.addAll(selected);
              });
            },
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

  void _showMultiSelectDropdown({
    required BuildContext context,
    required GlobalKey fieldKey,
    required List<String> items,
    required List<String> selectedItems,
    required int columns,
    required Function(List<String>) onSelectionChanged,
  }) {
    final RenderBox? renderBox =
        fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    List<String> tempSelected = List.from(selectedItems);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black26,
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              children: [
                Positioned(
                  left: position.dx,
                  top: position.dy + size.height + 4,
                  width: size.width,
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 300,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFCCD7),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: columns == 1
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: items.map((item) {
                                        return _buildCheckboxItem(
                                          item: item,
                                          isSelected:
                                              tempSelected.contains(item),
                                          onTap: () {
                                            setState(() {
                                              if (tempSelected.contains(item)) {
                                                tempSelected.remove(item);
                                              } else {
                                                tempSelected.add(item);
                                              }
                                            });
                                            onSelectionChanged(tempSelected);
                                          },
                                        );
                                      }).toList(),
                                    )
                                  : _buildTwoColumnLayout(
                                      items: items,
                                      tempSelected: tempSelected,
                                      onTap: (item) {
                                        setState(() {
                                          if (tempSelected.contains(item)) {
                                            tempSelected.remove(item);
                                          } else {
                                            tempSelected.add(item);
                                          }
                                        });
                                        onSelectionChanged(tempSelected);
                                      },
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTwoColumnLayout({
    required List<String> items,
    required List<String> tempSelected,
    required Function(String) onTap,
  }) {
    List<Widget> leftColumn = [];
    List<Widget> rightColumn = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final checkbox = _buildCheckboxItem(
        item: item,
        isSelected: tempSelected.contains(item),
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rightColumn,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxItem({
    required String item,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 18,
              height: 18,
              padding: EdgeInsets.only(top: 7),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Text(
                  item,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}