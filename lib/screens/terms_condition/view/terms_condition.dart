import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            LogoHeader(),
            const SizedBox(height: 29),

            // Title
            Text(
              'Terms & Conditions',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2C2C2C),
              ),
            ),

            const SizedBox(height: 29),

            // Content Box
            Container(
              height: 400,
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
                    Text(
                      'Last Updated: November 2025',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF9E9E9E),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 22),

                    _buildSection(
                      title: '1. Introduction',
                      content:
                          '1.1 These Terms and Conditions ("Terms") govern your access to and use of the MySheTribe UAE mobile application and related services (collectively, the "App" or "Service"). The App is operated by Aicend LLC-FZ ("Aicend", "we", "us", "our").\n\n1.2 By downloading, accessing or using the App, you agree to be bound by these Terms. If you do not agree to these Terms, you must not use the App.',
                    ),

                    _buildSection(
                      title: '2. Eligibility',
                      content:
                          '2.1 The App is intended solely for women aged 18 years and above.\n\n2.2 By using the App, you represent and warrant that you: (a) are at least 18 years old; and (b) have the legal capacity to enter into a binding agreement.',
                    ),

                    _buildSection(
                      title: '3. Account Registration',
                      content:
                          '3.1 To access certain features of the App, you may be required to create an account and provide certain information such as your name, email address and other profile details.\n\n3.2 You agree that all information you provide will be true, accurate, current and complete.\n\n3.3 You are responsible for maintaining the confidentiality of your login details and for all activities that occur under your account.',
                    ),

                    _buildSection(
                      title: '4. Community Guidelines',
                      content:
                          '4.1 MySheTribe is intended to be a positive, respectful and safe space for women. You agree that you will not:\n\n(a) harass, bully, threaten or abuse any other user;\n(b) post, share or transmit any content that is hateful, discriminatory, defamatory, obscene, sexually explicit, violent or otherwise inappropriate;\n(c) impersonate any person or entity;\n(d) use the App to send spam, scams, unsolicited promotions or any other unauthorised advertising.',
                    ),

                    _buildSection(
                      title: '5. Relocation & Advisory Disclaimer',
                      content:
                          '5.1 The information provided through the App, including but not limited to information relating to relocation, employment, accommodation, healthcare, schooling, public services and lifestyle, is for general informational purposes only.\n\n5.2 MySheTribe and Aicend do not provide legal, immigration, financial, tax, medical or other professional advice. You should always obtain independent professional advice before making any decisions.',
                    ),

                    _buildSection(
                      title: '6. Memberships & Events',
                      content:
                          '6.1 Certain features of the App, including premium content, memberships and events, may be subject to payment of fees.\n\n6.2 Unless required by applicable law or expressly stated otherwise, all membership fees and event ticket fees are non-refundable.',
                    ),

                    _buildSection(
                      title: '7. User Content',
                      content:
                          '7.1 You retain ownership of all text, images and other content that you upload, post or otherwise make available through the App ("User Content").\n\n7.2 By posting User Content, you grant us a non-exclusive, worldwide, royalty-free licence to use, store, reproduce, modify, adapt, publish and display such User Content as reasonably necessary to operate and improve the App.',
                    ),

                    _buildSection(
                      title: '8. Intellectual Property',
                      content:
                          '8.1 The App and all materials contained in it (excluding User Content), including the MySheTribe name, logo, design, text, graphics, software and other content, are owned by or licensed to Aicend and are protected by copyright, trade mark and other intellectual property laws.',
                    ),

                    _buildSection(
                      title: '9. Limitation of Liability',
                      content:
                          '9.1 To the fullest extent permitted by law, the App is provided on an "as is" and "as available" basis.\n\n9.2 Aicend, MySheTribe, their directors, officers, employees and agents shall not be liable for any indirect, consequential, incidental, special or punitive damages arising out of your use of the App.',
                    ),

                    _buildSection(
                      title: '10. Termination',
                      content:
                          '10.1 We may suspend or terminate your access to the App at any time if we reasonably believe that you have breached these Terms or violated our community guidelines.',
                    ),

                    _buildSection(
                      title: '11. Governing Law',
                      content:
                          '11.1 These Terms shall be governed by and construed in accordance with the laws of the United Arab Emirates.',
                    ),

                    _buildSection(
                      title: '12. Contact Details',
                      content:
                          'If you have any questions regarding these Terms, you may contact us at:\n\nEmail: info@myshetribe.ae\nCompany: Aicend LLC-FZ, Meydan Free Zone, Dubai, United Arab Emirates.',
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 29),

            // Bottom Tagline
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Connecting Women,\nCreating Community',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2C2C2C),
                  height: 1.3,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF3A3A3A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF2C2C2C),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}