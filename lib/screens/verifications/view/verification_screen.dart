import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/main.dart';
import 'package:myshetribe/screens/verifications/view/verification_complete.dart';
import 'package:myshetribe/screens/verifications/view/verification_pending.dart';
import 'package:myshetribe/screens/verifications/view/welcome_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  void _showInstructionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFE9CB4),
              borderRadius: BorderRadius.circular(0),
            ),
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.all(22),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    'Instructions',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF3A3A3A),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Instructions List
                  _buildInstructionItem('Hold phone at eye level.'),
                  const SizedBox(height: 12),
                  _buildInstructionItem('Ensure good lighting & background.'),
                  const SizedBox(height: 12),
                  _buildInstructionItem('Look forward and stay still.'),
                  const SizedBox(height: 12),
                  _buildInstructionItem('Press camera icon.'),
                  const SizedBox(height: 12),
                  _buildInstructionItem('Green tick = success.'),
                  const SizedBox(height: 12),
                  _buildInstructionItem('Red tick = try again.'),
                  const SizedBox(height: 12),
                  _buildInstructionItem('Success? Please submit and continue.'),
                  
                  const SizedBox(height: 30),
                  
                  // Close Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF3A3A3A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Text(
                        'Got it!',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInstructionItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Color(0xFFFF9AB4),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2C2C2C),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Logo Header
              LogoHeader(),
              const SizedBox(height: 29),
              
              // Verification Title
              Text(
                'Verification',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3A3A3A),
                ),
              ),
              const SizedBox(height: 29),
              
              // Main Content Container
              Container(
                height: 400,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 19),
                decoration: BoxDecoration(
                  color: const Color(0xFFFE9CB4),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 58),
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Background circular image
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/icons/verification_Pic.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            // Pink camera overlay with tap functionality
                            Positioned(
                              bottom: 40,
                              child: GestureDetector(
                                onTap: () {
                                  _showInstructionsDialog(context);
                                },
                                child: Container(
                                  width: 92,
                                  height: 115,
                                  child: Image.asset(
                                    'assets/icons/ver_camera.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(height: 6),
                      
                      // Text with styled parts
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF2C2C2C),
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                text: 'To ensure MySheTribe ',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF2C2C2C),
                                  height: 1.5,
                                ),
                              ),
                              TextSpan(
                                text: 'is a women only',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFFFF9AB4),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(text: ' platform, all members must '),
                              TextSpan(
                                text: 'complete identity verification',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFFFF9AB4),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' by taking a selfie. Thank you.',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF2C2C2C),
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 29),
              
              // Submit Button
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerificationCompleteScreen(
                          userName: 'Umair',
                        ),
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
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}