import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/profile/view/profile_setup_two.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _countryController = TextEditingController();

  String? _selectedAge;
  List<String> _selectedLanguages = [];
  List<String> _selectedProfessions = [];

  final List<String> _ageRanges = [
    '18 - 28 years',
    '29 - 39 years',
    '40 - 49 years',
    '50 - 60 years',
  ];

  final List<String> _languages = [
    'Arabic',
    'English',
    'French',
    'Spanish',
    'Portugese',
    'Russian',
    'Italian',
    'Germany',
    'Swahili',
    'Hausa',
    'Shona',
    'Zulu',
    'Urdu',
    'Punjabi',
    'Filipino Tagalog',
    'Other...',
  ];

  final List<String> _professions = [
    'Banking',
    'Tech',
    'Real Estate',
    'Teaching',
    'Hospitality',
    'Retail',
    'Construction',
    'Entrepreneur',
    'Influencer',
    'Medical',
    'Nursing',
    'Other',
  ];

  @override
  void dispose() {
    _countryController.dispose();
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
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 22),
                          _buildSingleSelectField(
                            selectedItem: _selectedAge,
                            hintText: 'Age',
                            items: _ageRanges,
                             showIcon: false, // Add this parameter
                            columns: 1,
                            onChanged: (value) {
                              setState(() {
                                _selectedAge = value;
                              });
                            },
                          ),
                          const SizedBox(height: 22),
                          _buildTextField(
                            controller: _countryController,
                            hintText: 'Nationality',
                          ),
                          const SizedBox(height: 22),
                          _buildMultiSelectField(
                            selectedItems: _selectedLanguages,
                            hintText: 'Language',
                            title: 'Select Languages',
                            items: _languages,
                            columns: 2,
                            onChanged: (values) {
                              setState(() {
                                _selectedLanguages = values;
                              });
                            },
                          ),
                          const SizedBox(height: 22),
                          _buildMultiSelectField(
                            selectedItems: _selectedProfessions,
                            hintText: 'Profession',
                            title: 'Select Professions',
                            items: _professions,
                            columns: 2,
                            onChanged: (values) {
                              setState(() {
                                _selectedProfessions = values;
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
                            builder: (context) => ProfileSetupTwo(),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF2C2C2C),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF2C2C2C),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          constraints: BoxConstraints(maxHeight: 55, minHeight: 55),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }

 Widget _buildSingleSelectField({
    required String? selectedItem,
    required String hintText,
    required List<String> items,
    required int columns,
    required Function(String?) onChanged,
    bool showIcon = true, // Add this parameter
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
            title: 'Select $hintText',
            items: items,
            selectedItem: selectedItem,
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
                  selectedItem ?? hintText,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2C2C2C),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (showIcon) // Only show icon if showIcon is true
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
                  selectedItems.isEmpty
                      ? hintText
                      : selectedItems.join(', '),
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
    required int columns,
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
                        child: columns == 1
                            ? Column(
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
                              )
                            : _buildDialogTwoColumnLayout(
                                items: items,
                                selectedItem: tempSelected,
                                onTap: (item) {
                                  setState(() {
                                    tempSelected = item;
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

  void _showMultiSelectDialog({
    required BuildContext context,
    required String title,
    required List<String> items,
    required List<String> selectedItems,
    required int columns,
    required Function(List<String>) onChanged,
  }) {
    List<String> tempSelected = List.from(selectedItems);
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
                          children: [
                            columns == 1
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
                                : _buildDialogTwoColumnLayoutMulti(
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
                            // Show TextField when "Other..." or "Other" is selected
                            if (tempSelected.contains('Other...') || tempSelected.contains('Other'))
                              Padding(
                                padding: const EdgeInsets.only(top: 16, bottom: 8),
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
                                // Replace "Other..." or "Other" with custom text if entered
                                if (otherController.text.isNotEmpty) {
                                  if (tempSelected.contains('Other...')) {
                                    tempSelected.remove('Other...');
                                    tempSelected.add(otherController.text);
                                  } else if (tempSelected.contains('Other')) {
                                    tempSelected.remove('Other');
                                    tempSelected.add(otherController.text);
                                  }
                                }
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
    required String? selectedItem,
    required Function(String) onTap,
  }) {
    List<Widget> leftColumn = [];
    List<Widget> rightColumn = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final checkbox = _buildDialogCheckboxItem(
        item: item,
        isSelected: selectedItem == item,
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

  Widget _buildDialogTwoColumnLayoutMulti({
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