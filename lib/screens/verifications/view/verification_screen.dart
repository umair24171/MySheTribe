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
                    children: [
                      // Safety Message
                      Text(
                        'To keep MySheTribe Safe, all\n members must complete identity verification by taking a selfie.\n Thank you.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: size.width*0.032,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2C2C2C),
                          height: 1.5,
                        ),
                      ),
                         const SizedBox(height: 16),
                  
                      Image.asset('assets/icons/verification_camera.png',width: 77,height: 94,),
                      
                      // // Camera Icon
                      // Container(
                      //   padding: const EdgeInsets.all(20),
                      //   decoration: BoxDecoration(
                      //     color: const Color(0xFF3A3A3A),
                      //     borderRadius: BorderRadius.circular(12),
                      //   ),
                      //   child: const Icon(
                      //     Icons.camera_alt,
                      //     size: 50,
                      //     color: Colors.white,
                      //   ),
                      // ),
                         const SizedBox(height: 16),
                      
                      // Instructions
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Instructions:',
                          style: GoogleFonts.poppins(
                          fontSize: size.width*0.032,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2C2C2C),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      
                      // Instruction Items
                      _buildInstruction('1. Find a place with good light'),
                      const SizedBox(height: 10),
                      _buildInstruction('2. Clear background'),
                      const SizedBox(height: 10),
                      _buildInstruction('3. Facing the camera press'),
                      const SizedBox(height: 10),
                      _buildInstruction('4. Hold until you get a green tick'),
                      const SizedBox(height: 10),
                      _buildInstruction('5. Red tick try again'),
                      const SizedBox(height: 0),
                      
                      
                    ],
                  ),
                ),
              ),
                   const SizedBox(height: 29),
              // Submit Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.75,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationCompleteScreen(userName: 'Umair',)));
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
                      // const SizedBox(height: 30),
            
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstruction(String text,) {
    //  var size=MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.poppins(
        fontSize:MediaQuery.of(navigatorKey!.currentContext!).size.width*0.032,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF2C2C2C),
        ),
      ),
    );
  }
}