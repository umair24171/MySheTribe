import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/profile/view/profile_screen.dart';
import 'package:myshetribe/screens/verifications/view/ai_tribe_matching.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class VerificationCompleteScreen extends StatelessWidget {
  final String userName;
  final String? profileImageUrl; // Optional profile image
  
  const VerificationCompleteScreen({
    Key? key, 
    required this.userName,
    this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var size=MediaQuery.of(context).size;
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
              
              // Welcome Title
              Text(
                'Welcome $userName',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3A3A3A),
                ),
              ),
              const SizedBox(height: 29),
              
              // Main Content Container - SAME STRUCTURE AS VERIFICATION SCREEN
              Container(
                height: 400,
                margin: const EdgeInsets.symmetric(horizontal: 19),
                // padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFFE9CB4),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 22,vertical: 22),
                 padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Thank you message
                      Text(
                        'Thank you for verifying your identity.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                        fontSize:14,
                          fontWeight: FontWeight.w700,
                          color:  Colors.white,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 22),
                      
                      // Profile Image Circle 
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
                     
                      
                      // Continue message
                        Text(
                        'Thank you for verifying your identity.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                        fontSize:16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2C2C2C),
                          height: 1.5,
                        ),
                                              ),
                                               const SizedBox(height: 22),
                      // Text(
                      //   'Please continue and complete you the AI Tribe Matching Profile so we can match you with your Tribe.',
                      //   textAlign: TextAlign.center,
                      //   style: GoogleFonts.poppins(
                      //    fontSize: 14,
                      //     fontWeight: FontWeight.w700,
                      //     color: const Color(0xFF2C2C2C),
                      //     height: 1.5,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 29),
              
              // Continue Button
              SizedBox(
                 width: MediaQuery.of(context).size.width*0.75,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AiTribeMatching()),
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
                    'Continue',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}