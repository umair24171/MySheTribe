import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myshetribe/screens/booking_confirmation/view/booking_confirmation_screen.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/widgets/logo_header.dart';
import 'package:myshetribe/models/event_model.dart';
import 'package:myshetribe/providers/event_provider.dart';
import 'package:myshetribe/providers/auth_provider.dart';

class EventDetailScreen extends StatefulWidget {
  final EventModel? event;

  const EventDetailScreen({Key? key, this.event}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _selectedPaymentMethod = 'credit_card';
  bool _agreedToTerms = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.currentUser != null) {
        _nameController.text = authProvider.currentUser!.fullName;
        _emailController.text = authProvider.currentUser!.email;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

 @override
Widget build(BuildContext context) {
  // Use dummy event if no event passed (fallback for existing navigation)
  final event = widget.event ?? EventModel(
    id: 'dummy',
    title: 'MyHighTea',
    description: 'Join us for our launch High Tea',
    location: 'Jumeriah AL Qasr',
    city: 'Dubai',
    eventDate: DateTime.now().add(Duration(days: 30)),
    price: 250,
    maxAttendees: 50,
    attendeeIds: [],
    organizerId: 'admin',
    category: 'social',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    isActive: true,
  );

  return Scaffold(
    backgroundColor: const Color(0xFFFFB6C8),
     bottomNavigationBar: CustomBottomNavBar(selectedIndex:1 ,onItemTapped: (p0) {

      },),
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
              event.title,
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
                color: const Color(0xFFD4A574),
              ),
              child: event.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: event.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: const Color(0xFF2C2C2C),
                          strokeWidth: 2,
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/icons/my_events_header_pic.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      'assets/icons/my_events_header_pic.png',
                      fit: BoxFit.cover,
                    ),
            ),
            // Overlapping Gold Container (using Transform to move it up)
            Transform.translate(
              offset: const Offset(0, -80), // Moves it up by 80px to overlap
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 22,
                    right: 22,
                    bottom: 47.5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4A574),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event Details
                      _buildDetailRow(Icons.calendar_today, DateFormat('EEE dd MMM . h:mm a').format(event.eventDate)),
                      const SizedBox(height: 6),
                      _buildDetailRow(Icons.location_on, event.location),
                      const SizedBox(height: 6),
                      _buildDetailRow(Icons.people, '${event.attendeeIds.length}/${event.maxAttendees} attending'),
                      const SizedBox(height: 20),
                      // Name Field
                      _buildTextField('Name', _nameController),
                      const SizedBox(height: 12),
                      // Email Field
                      _buildTextField('Email', _emailController),
                      const SizedBox(height: 18),
                      // Payment Method
                      Text(
                        'Payment Method',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2C2C2C),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Payment Options
                      Row(
                        children: [
                          _buildRadioOption('Credit Card', 'credit_card'),
                          const SizedBox(width: 30),
                          _buildRadioOption('Apple Pay', 'apple_pay'),
                        ],
                      ),
                      const SizedBox(height: 18),
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
                            event.isPaid ? 'AED ${event.price!.toInt()}' : 'Free',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2C2C2C),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
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
                                color: Color(0xFF2C2C2C),
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
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF2C2C2C),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      // Pay/RSVP Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (_agreedToTerms && !_isProcessing && !event.isFull) ? () async {
                            final authProvider = Provider.of<AuthProvider>(context, listen: false);
                            final eventProvider = Provider.of<EventProvider>(context, listen: false);

                            if (authProvider.currentUser == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please login to book this event'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            setState(() {
                              _isProcessing = true;
                            });

                            try {
                              // Add attendee to event
                              bool success = await eventProvider.addEventAttendee(
                                event.id,
                                authProvider.currentUser!.uid,
                              );

                              setState(() {
                                _isProcessing = false;
                              });

                              if (success) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingConfirmationScreen(eventName: event.title),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to book event'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } catch (e) {
                              setState(() {
                                _isProcessing = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF000000),
                            disabledBackgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
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
                                  event.isFull
                                      ? 'Event Full'
                                      : (event.isPaid ? 'Pay AED ${event.price!.toInt()}' : 'RSVP Free'),
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
              ),
            ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label,
        //   style: GoogleFonts.poppins(
        //     fontSize: 16,
        //     fontWeight: FontWeight.w600,
        //     color: const Color(0xFF2C2C2C),
        //   ),
        // ),
        // const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFD4A574),
            border: Border.all(
              color: const Color(0xFF2C2C2C),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextField(
            controller: controller,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2C2C2C),
            ),
            decoration:  InputDecoration(
              hint:  Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF2C2C2C),
          ),
        ),
              hintStyle:  GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2C2C2C),
            ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
          ),
        ),
      ],
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