import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/widgets/logo_header.dart';

// ============= HELP & SUPPORT SCREEN =============
class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final List<HelpCategory> categories = [
    HelpCategory(
      title: 'Getting Started',
      icon: Icons.rocket_launch,
      topics: [
        'How to create an account',
        'Profile verification process',
        'Setting up your profile',
        'Understanding AI Tribe Matching',
      ],
    ),
    HelpCategory(
      title: 'Tribes & Community',
      icon: Icons.groups,
      topics: [
        'How to join a Tribe',
        'Creating your own Tribe',
        'Tribe chat guidelines',
        'Finding the right Tribe for you',
      ],
    ),
    HelpCategory(
      title: 'Events & Bookings',
      icon: Icons.event,
      topics: [
        'How to book an event',
        'Payment methods',
        'Cancellation policy',
        'Event refunds',
      ],
    ),
    HelpCategory(
      title: 'Account & Privacy',
      icon: Icons.security,
      topics: [
        'Managing your privacy settings',
        'Changing your password',
        'Deleting your account',
        'Data security',
      ],
    ),
    HelpCategory(
      title: 'Safety & Guidelines',
      icon: Icons.shield,
      topics: [
        'Community guidelines',
        'Reporting inappropriate content',
        'Blocking users',
        'Safety tips',
      ],
    ),
    HelpCategory(
      title: 'Partnership & Offers',
      icon: Icons.local_offer,
      topics: [
        'Accessing partner discounts',
        'How to use promo codes',
        'Partner benefits',
        'Becoming a partner',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Back and Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // GestureDetector(
                  //   onTap: () => Navigator.pop(context),
                  //   child: Container(
                  //     width: 40,
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: const Icon(
                  //       Icons.arrow_back,
                  //       color: Color(0xFF3A3A3A),
                  //       size: 24,
                  //     ),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     // Search functionality
                  //   },
                  //   child: Container(
                  //     width: 40,
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: const Icon(
                  //       Icons.search,
                  //       color: Color(0xFF3A3A3A),
                  //       size: 24,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            LogoHeader(),
            const SizedBox(height: 29),

            Text(
              'Help & Support',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF3A3A3A),
              ),
            ),

            const SizedBox(height: 29),

            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 19),
                decoration: BoxDecoration(
                  color: const Color(0xFFFE9CB4),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Container(
                  margin: const EdgeInsets.all(22),
                  color: Colors.white,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: categories.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return _buildCategoryCard(categories[index]);
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 29),

            // Contact Support Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Contact support
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3A3A3A),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: Text(
                    'Contact Support',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(HelpCategory category) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBFC),
        borderRadius: BorderRadius.circular(0),
        border: Border.all(
          color: const Color(0xFFFFE0E9),
          width: 1,
        ),
      ),
      child: ExpansionTile(
        leading: Icon(
          category.icon,
          color: const Color(0xFFFF9AB4),
          size: 28,
        ),
        title: Text(
          category.title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF3A3A3A),
          ),
        ),
        children: category.topics.map((topic) {
          return InkWell(
            onTap: () {
              // Navigate to detailed help article
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFFFE0E9),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 44),
                  Expanded(
                    child: Text(
                      topic,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF2C2C2C),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0xFF9E9E9E),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class HelpCategory {
  final String title;
  final IconData icon;
  final List<String> topics;

  HelpCategory({
    required this.title,
    required this.icon,
    required this.topics,
  });
}
