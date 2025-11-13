import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/verifications/view/verification_complete.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class VerificationPendingScreen extends StatelessWidget {
  const VerificationPendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Logo and Branding
                LogoHeader(),
                const SizedBox(height: 20),
                // Verification Pending Title
                Text(
                  'Verification Pending',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF3A3A3A),
                  ),
                ),
                 const SizedBox(height: 20),
             Container(
                 margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFFE9CB4),
                  borderRadius: BorderRadius.circular(0),
                ),
              child: Column(children: [
                 const SizedBox(height: 20),
                // Camera Icon Container
                Container(
                  width: 260,
                  height: 246,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Center(
                    child: Image.asset('assets/icons/camera.png')
                  ),
                ),
                const SizedBox(height: 30),
                // Description Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Your profile is under review. We will let you know once the verification is completed and approved. Thank you.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2C2C2C),
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
             ],),),
              const SizedBox(height: 20),
                // Submit Button
                SizedBox(
                  width: 317,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationCompleteScreen(userName: 'Umair',)));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFF3A3A3A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                 const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '🦋',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 10),
            Text(
              'UAE',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          'MySheTribe',
          style: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'CONNECTING WOMEN,',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        Text(
          'CREATING COMMUNITY',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}