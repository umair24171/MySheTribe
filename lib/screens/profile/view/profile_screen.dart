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
  String? _selectedLanguage;
  String? _selectedProfession;

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
                          _buildSingleSelectField(
                            selectedItem: _selectedAge,
                            hintText: 'Age',
                            items: _ageRanges,
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
                          _buildSingleSelectField(
                            selectedItem: _selectedLanguage,
                            hintText: 'Language',
                            items: _languages,
                            columns: 2,
                            onChanged: (value) {
                              setState(() {
                                _selectedLanguage = value;
                              });
                            },
                          ),
                          const SizedBox(height: 22),
                          _buildSingleSelectField(
                            selectedItem: _selectedProfession,
                            hintText: 'Profession',
                            items: _professions,
                            columns: 2,
                            onChanged: (value) {
                              setState(() {
                                _selectedProfession = value;
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
          _showSingleSelectDropdown(
            context: context,
            fieldKey: fieldKey,
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

  void _showSingleSelectDropdown({
    required BuildContext context,
    required GlobalKey fieldKey,
    required List<String> items,
    required String? selectedItem,
    required int columns,
    required Function(String?) onChanged,
  }) {
    final RenderBox? renderBox =
        fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Calculate available space below and above the field
    final spaceBelow = screenHeight - (position.dy + size.height);
    final spaceAbove = position.dy;
    
    // Determine if dropdown should appear above or below
    final showAbove = spaceBelow < 150;
    
    // Calculate max height based on available space
    final maxHeight = showAbove 
        ? (spaceAbove - 10).clamp(150.0, 300.0)
        : (spaceBelow - 20).clamp(150.0, 300.0);

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
                  top: showAbove 
                      ? position.dy - maxHeight - 4
                      : position.dy + size.height + 4,
                  width: size.width,
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: maxHeight,
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
                                          isSelected: selectedItem == item,
                                          onTap: () {
                                            onChanged(item);
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      }).toList(),
                                    )
                                  : _buildTwoColumnLayout(
                                      items: items,
                                      selectedItem: selectedItem,
                                      onTap: (item) {
                                        onChanged(item);
                                        Navigator.of(context).pop();
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
    required String? selectedItem,
    required Function(String) onTap,
  }) {
    List<Widget> leftColumn = [];
    List<Widget> rightColumn = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final checkbox = _buildCheckboxItem(
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
          children: [
            Container(
              width: 18,
              height: 18,
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
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}