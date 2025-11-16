
// ============= PRIVACY POLICY SCREEN =============
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
                const SizedBox(height: 10),
              // // Top Bar with Back
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
              //   child: Row(
              //     children: [
              //       GestureDetector(
              //         onTap: () => Navigator.pop(context),
              //         child: Container(
              //           width: 40,
              //           height: 40,
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //           child: const Icon(
              //             Icons.arrow_back,
              //             color: Color(0xFF3A3A3A),
              //             size: 24,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
        
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
                decoration: BoxDecoration(
                  color: const Color(0xFFFE9CB4),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Container(
                  margin: const EdgeInsets.all(22),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
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
                              'MySheTribe is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our women-only community platform.',
                        ),
              
                        _buildSection(
                          title: '2. Information We Collect',
                          content:
                              'We collect information that you provide directly to us, including:\n\n• Profile information (name, email, phone number, photo)\n• Verification documents for identity confirmation\n• Interests, languages, and location preferences\n• Bio and profile descriptions\n• Chat messages and interactions within Tribes\n• Event bookings and payment information\n• Device information and usage data',
                        ),
              
                        _buildSection(
                          title: '3. AI Tribe Matching',
                          content:
                              'We use AI technology to recommend relevant Tribes based on your profile:\n\n• Your bio and interests are analyzed using text embeddings\n• No raw personal data is sent to AI providers\n• Only anonymized text is processed\n• You can edit your interests anytime to refine recommendations\n• Matching considers interests, location, languages, and Tribe activity',
                        ),
              
                        _buildSection(
                          title: '4. How We Use Your Information',
                          content:
                              'We use your information to:\n\n• Verify your identity and maintain a women-only platform\n• Provide personalized Tribe recommendations\n• Facilitate communication within Tribes\n• Process event bookings and payments\n• Send notifications about events, messages, and updates\n• Improve our services and user experience\n• Ensure platform safety and security',
                        ),
              
                        _buildSection(
                          title: '5. Data Sharing',
                          content:
                              'We do not sell your personal information. We may share your information with:\n\n• Other members within your Tribes (profile information only)\n• Service providers (Firebase, Stripe, AI embedding services)\n• Law enforcement when required by law\n• Partners for exclusive offers (with your consent)',
                        ),
              
                        _buildSection(
                          title: '6. Data Security',
                          content:
                              'We implement security measures including:\n\n• Encrypted data transmission\n• Secure Firebase backend\n• Manual verification of all members\n• Regular security audits\n• Limited access to personal information',
                        ),
              
                        _buildSection(
                          title: '7. Your Rights',
                          content:
                              'You have the right to:\n\n• Access your personal data\n• Update or correct your information\n• Delete your account\n• Opt-out of promotional communications\n• Request a copy of your data\n• Object to AI processing',
                        ),
              
                        _buildSection(
                          title: '8. Data Retention',
                          content:
                              'We retain your information for as long as your account is active. After account deletion, we may retain certain data for legal compliance and fraud prevention.',
                        ),
              
                        _buildSection(
                          title: '9. Children\'s Privacy',
                          content:
                              'MySheTribe is only for women aged 18 and above. We do not knowingly collect information from minors.',
                        ),
              
                        _buildSection(
                          title: '10. Changes to Privacy Policy',
                          content:
                              'We may update this policy periodically. We will notify you of significant changes through the app or via email.',
                        ),
              
                        _buildSection(
                          title: '11. Contact Us',
                          content:
                              'If you have questions about this Privacy Policy, contact us at:\n\nEmail: privacy@myshetribe.com\nAddress: Dubai, UAE',
                        ),
              
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
        
              const SizedBox(height: 29),
        
              // Accept Button
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