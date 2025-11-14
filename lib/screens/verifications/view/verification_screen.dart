import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/main.dart';
import 'package:myshetribe/screens/verifications/view/verification_complete.dart';
import 'package:myshetribe/screens/verifications/view/verification_pending.dart';
import 'package:myshetribe/screens/verifications/view/welcome_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

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
                      // Circular Image with Camera Overlay
                        //  const SizedBox(height: 44),
                         const SizedBox(height: 66),
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
                                  image:AssetImage('assets/icons/verification_Pic.png') , // Replace with your image
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            // CircleAvatar(radius: 90,backgroundColor: Colors.transparent ,child:Image.asset('assets/icons/verification_Pic.png',fit: BoxFit.contain,) ,),
                            // Pink camera overlay
                            Positioned(
                              bottom: 40,
                             
                              child: Container(
                                width: 92,
                                height: 115,
                                // decoration: BoxDecoration(
                                //   color: const Color(0xFFFF9AB4),
                                //   borderRadius: BorderRadius.circular(12),
                                // ),
                                child:
                                Image.asset('assets/icons/ver_camera.png',fit: BoxFit.contain,)
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      
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
                              TextSpan(text: 'To ensure MySheTribe ',  style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF2C2C2C),
                              height: 1.5,
                            ),),
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
                              TextSpan(text: ' by taking a selfie. Thank you.', style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF2C2C2C),
                              height: 1.5,
                            )),
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