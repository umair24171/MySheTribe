import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class PublicGuide extends StatelessWidget {
  const PublicGuide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
       bottomNavigationBar: CustomBottomNavBar(selectedIndex:2 ,onItemTapped: (p0) {
        
      },),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            LogoHeader(),
            const SizedBox(height: 29),

            // Title
            Text(
              'Public Services',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2C2C2C),
              ),
            ),

            const SizedBox(height: 29),

            // Content
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 19),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Article Title
                      Text(
                        'Top Ten Suburbs to Live in Dubai',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2C2C2C),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Article Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=800',
                          width: 222,
                          height: 124,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 140,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image, size: 60),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Article Content - Paragraph 1
                      Text(
                        'Dubai Hills is one of the best places to live in Dubai. It is suitable for both young couples and those with young families. There is an excellent shopping Mall "Dubai Hills Mall" which has alot of restaurants family friendly and thing for kids to do.',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF2C2C2C),
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Article Content - Paragraph 2
                      Text(
                        'Explore the best neighbourhood for expert women in UAE, considering factor like safety, amenities, and community.',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF2C2C2C),
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Article Content - Paragraph 3 (repeated)
                      Text(
                        'Dubai Hills is one of the best places to live in Dubai. It is suitable for both young couples and those with young families. There is an excellent shopping Mall "Dubai Hills Mall" which has alot of restaurants family friendly and thing for kids to do.',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF2C2C2C),
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Article Content - Paragraph 4
                      Text(
                        'Explore the best neighbourhood for expert women in UAE, considering factor like safety, amenities, and community.',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF2C2C2C),
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}