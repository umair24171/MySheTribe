import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/booking_confirmation/view/booking_confirmation_screen.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({Key? key}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _selectedPaymentMethod = 'credit_card';
  bool _agreedToTerms = false;

  // Dummy data
  final String eventTitle = 'MyHighTea';
  final String eventImage = 'assets/icons/my_events_header_pic.png';
  final String date = 'Sat 22 Nov . 3:PM';
  final String location = 'Jumeriah AL Qasr';
  final String dresscode = 'Elegant Pink';
  final double price = 250;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1,
        onItemTapped: (p0) {},
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Header Logo
              LogoHeader(),
              const SizedBox(height: 29),
              // Event Title
              Text(
                eventTitle,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2C2C2C),
                ),
              ),
              const SizedBox(height: 29),
              // Event Image
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(eventImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Overlapping Gold Container with Button
              Transform.translate(
                offset: const Offset(0, -80), // Moves it up by 80px to overlap
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Golden Container
                          Container(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 22,
                              right: 22,
                              bottom: 20,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4A574),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Event Details
                                _buildDetailRow(Icons.calendar_today, date),
                                const SizedBox(height: 6),
                                _buildDetailRow(Icons.location_on, location),
                                const SizedBox(height: 6),
                                _buildDetailRow(Icons.checkroom, dresscode),
                                const SizedBox(height: 22),
                                // Name Field
                                _buildTextField('Name', _nameController),
                                const SizedBox(height: 22),
                                // Email Field
                                _buildTextField('Email', _emailController),
                                const SizedBox(height: 22),
                                // Payment Method
                                Text(
                                  'Payment Method',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF2C2C2C),
                                  ),
                                ),
                                const SizedBox(height: 22),
                                // Payment Options
                                Row(
                                  children: [
                                    _buildRadioOption('Credit Card', 'credit_card'),
                                    const SizedBox(width: 30),
                                    _buildRadioOption('Apple Pay', 'apple_pay'),
                                  ],
                                ),
                                const SizedBox(height: 22),
                                // Total
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF2C2C2C),
                                      ),
                                    ),
                                    Text(
                                      'AED ${price.toInt()}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF2C2C2C),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 22),
                                // Terms Checkbox
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: Checkbox(
                                        value: _agreedToTerms,
                                        onChanged: (value) {
                                          setState(() {
                                            _agreedToTerms = value ?? false;
                                          });
                                        },
                                        side: const BorderSide(
                                          color: const Color(0xFF000000),
                                          width: 2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                        activeColor: Colors.transparent,
                                        checkColor: const Color(0xFF2C2C2C),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'I agree to terms & conditions',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF000000),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Button placed OUTSIDE the Stack to avoid clipping
                      Transform.translate(
                        offset: const Offset(0, 0),
                        child: Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width*0.75,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingConfirmationScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: const Color(0xFF3A3A3A),
                              disabledBackgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            child: Text(
                              'Pay AED ${price.toInt()}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Add some bottom spacing
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: const Color(0xFF2C2C2C),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF2C2C2C),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFFD4A574),
        border: Border.all(
          color: const Color(0xFF2C2C2C),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF2C2C2C),
        ),
        decoration: InputDecoration(
          hint: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2C2C2C),
            ),
          ),
          hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF2C2C2C),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String label, String value) {
    final isSelected = _selectedPaymentMethod == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF2C2C2C),
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF2C2C2C),
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2C2C2C),
            ),
          ),
        ],
      ),
    );
  }
}