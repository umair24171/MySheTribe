import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/custom_bottom_bar.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class AITribeMatchingScreen extends StatefulWidget {
  const AITribeMatchingScreen({Key? key}) : super(key: key);

  @override
  State<AITribeMatchingScreen> createState() => _AITribeMatchingScreenState();
}

class _AITribeMatchingScreenState extends State<AITribeMatchingScreen> {
  @override
  Widget build(BuildContext context) {
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
              
              // AI Tribe Matching Title
              Text(
                'AI Tribe Matching',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2C2C2C),
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
                 padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 10),
                  child: Column(
                    children: [
                      // Top Message
                      Text(
                        'We are working on matching you with your Tribe based on the profile.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                       fontSize: MediaQuery.of(context).size.width*0.034,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2C2C2C),
                          height: 1.5,
                        ),
                      ),
                      
                      const SizedBox(height: 22),
                      
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.asset(
                          'assets/icons/tribe_matching.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                      
                      const SizedBox(height: 22),
                      
                      // Bottom Message
                      Text(
                        'We will notify you when we have a match. Please go ahead and explore the app.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                         fontSize: MediaQuery.of(context).size.width*0.034,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2C2C2C),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 29),
              
              // Main Menu Button
              SizedBox(
               width: MediaQuery.of(context).size.width*0.75,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainNavigationScreen(),
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
                    'Main Menu',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}