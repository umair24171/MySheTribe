import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/main.dart';
import 'package:myshetribe/screens/accomodation_guide/view/accomodation_article_screen.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class AccommodationGuideScreen extends StatelessWidget {
  const AccommodationGuideScreen({Key? key}) : super(key: key);

  final List<String> _buttonTitles = const [
    'Types of\nAccommodation',
    'Top 5 Cities in UAE',
    'Tenancy Agreements,\nEjari, Prices',
    'Estate Agents',
    'Top Suburbs to\nLive',
    'Online Property\nFinders Top 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
       bottomNavigationBar: CustomBottomNavBar(selectedIndex:2 ,onItemTapped: (p0) {
        
      },),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            LogoHeader(),
            const SizedBox(height: 20),

            // Title
            Text(
              'Accommodation Guide',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2C2C2C),
              ),
            ),

            const SizedBox(height: 10),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Hero Image
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      height: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=800',
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.image, size: 80),
                            );
                          },
                        ),
                      ),
                    ),

                    // Description Section
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                       color: const Color(0xFFFE9CB4),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Accommodation Rules UAE',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2C2C2C),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Explore the best neighbourhood for expert women in UAE, considering factor like safety, amenities, and community.',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF2C2C2C),
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Read more...',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF2C2C2C),
                              ),
                            ),
                          ),
                            const SizedBox(height: 15),

                    // Grid Buttons
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          mainAxisExtent: 60,
                        ),
                        itemCount: _buttonTitles.length,
                        itemBuilder: (context, index) {
                          return _buildActionButton(_buttonTitles[index]);
                        },
                      ),
                    ),
                        ],
                      ),
                    ),

                  

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title) {
    return InkWell(
      onTap: () {
        Navigator.push(navigatorKey!.currentContext!, MaterialPageRoute(builder: (context)=>AccommodationArticleScreen()));
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF3A3A3A),
          borderRadius: BorderRadius.circular(0),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}