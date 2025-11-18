import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

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

            Text(
              'Privacy Policy',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF3A3A3A),
              ),
            ),

            const SizedBox(height: 29),

            Container(
              height: 400,
              margin: const EdgeInsets.symmetric(horizontal: 19),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(0),
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
                          '1.1 This Privacy Policy explains how MySheTribe UAE ("MySheTribe", "we", "us", "our") collects, uses, shares and protects your personal data when you use our mobile application and related services (the "App").\n\n1.2 By using the App, you agree to the collection and use of your personal data in accordance with this Privacy Policy.',
                    ),

                    _buildSection(
                      title: '2. Information We Collect',
                      content:
                          '2.1 Information you provide directly:\n\n(a) Account information, such as your name, email address, password, country/region and basic profile details;\n(b) Profile information, such as age group, interests, relocation status;\n(c) Responses to relocation and support questions;\n(d) Content you share within the App, including messages, posts, photos, comments, event RSVPs;\n(e) Payment-related information provided through app stores or payment processors.\n\n2.2 Information collected automatically:\n\n(a) Device information, such as device type, operating system, app version;\n(b) Usage information, such as screens viewed, features used, clicks;\n(c) Approximate location information derived from your IP address.',
                    ),

                    _buildSection(
                      title: '3. How We Use Your Information',
                      content:
                          '3.1 We use your personal data for:\n\n(a) To provide, operate and maintain the App;\n(b) To enable community features, such as chats, events, tribes;\n(c) To personalise your experience;\n(d) To communicate with you regarding your account and service messages;\n(e) To send optional notifications or marketing communications;\n(f) To improve and develop the App;\n(g) To maintain security and prevent fraud.',
                    ),

                    _buildSection(
                      title: '4. Legal Bases for Processing',
                      content:
                          '4.1 Where data protection laws require a legal basis, we rely on:\n\n(a) Performance of a contract;\n(b) Legitimate interests;\n(c) Consent for certain optional uses;\n(d) Legal obligation to comply with laws.',
                    ),

                    _buildSection(
                      title: '5. How We Share Your Information',
                      content:
                          '5.1 We do not sell your personal data. We may share your information with:\n\n(a) Service providers who support our operations (hosting, analytics, notifications, payment processors);\n(b) Other users of the App, where you choose to share content;\n(c) Legal and regulatory authorities when required by law;\n(d) Third parties in connection with business transactions.',
                    ),

                    _buildSection(
                      title: '6. Data Storage and Retention',
                      content:
                          '6.1 Your data may be stored on servers located inside or outside the United Arab Emirates.\n\n6.2 We retain personal data for as long as reasonably necessary to provide the App and comply with legal obligations.',
                    ),

                    _buildSection(
                      title: '7. Your Rights and Choices',
                      content:
                          '7.1 Depending on applicable law, you may have the right to:\n\n(a) Request access to your personal data;\n(b) Request correction of inaccurate data;\n(c) Request deletion of your personal data;\n(d) Object to or request restriction of processing;\n(e) Withdraw consent where applicable.',
                    ),

                    _buildSection(
                      title: '8. Children\'s Privacy',
                      content:
                          '8.1 The App is not intended for use by persons under the age of 18.\n\n8.2 We do not knowingly collect personal data from children under 18.',
                    ),

                    _buildSection(
                      title: '9. Data Security',
                      content:
                          '9.1 We implement reasonable technical and organisational measures designed to protect your personal data against unauthorised access, loss, misuse or alteration.\n\n9.2 However, no system can be guaranteed to be 100% secure.',
                    ),

                    _buildSection(
                      title: '10. International Transfers',
                      content:
                          '10.1 Your personal data may be transferred to and processed in countries other than your country of residence.\n\n10.2 Where required by law, we will ensure appropriate safeguards are in place.',
                    ),

                    _buildSection(
                      title: '11. Changes to Privacy Policy',
                      content:
                          '11.1 We may update this Privacy Policy from time to time. We will notify you of changes via the App or by email where practicable.',
                    ),

                    _buildSection(
                      title: '12. Contact Us',
                      content:
                          'If you have any questions about this Privacy Policy, contact us at:\n\nEmail: info@myshetribe.ae\nCompany: Aicend LLC-FZ, Meydan Free Zone, Dubai, United Arab Emirates.',
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 29),

            // I Understand Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3A3A3A),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: Text(
                    'I Understand',
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