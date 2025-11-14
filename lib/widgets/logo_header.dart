
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return 
    Column(
      children: [
        Image.asset('assets/icons/new_logo.png',height: 130,
        width:  MediaQuery.of(context).size.width*0.95,
        fit: BoxFit.cover,)
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const Text(
        //       '🦋',
        //       style: TextStyle(fontSize: 24),
        //     ),
        //     const SizedBox(width: 10),
        //     Text(
        //       'UAE',
        //       style: GoogleFonts.poppins(
        //         fontSize: 24,
        //         fontWeight: FontWeight.w600,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 5),
        // Text(
        //   'MySheTribe',
        //   style: GoogleFonts.poppins(
        //     fontSize: 36,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.white,
        //     letterSpacing: 1.5,
        //   ),
        // ),
        // const SizedBox(height: 5),
        // Text(
        //   'CONNECTING WOMEN,',
        //   style: GoogleFonts.poppins(
        //     fontSize: 14,
        //     fontWeight: FontWeight.w500,
        //     color: Colors.white,
        //     letterSpacing: 2,
        //   ),
        // ),
        // Text(
        //   'CREATING COMMUNITY',
        //   style: GoogleFonts.poppins(
        //     fontSize: 14,
        //     fontWeight: FontWeight.w500,
        //     color: Colors.white,
        //     letterSpacing: 2,
        //   ),
        // ),
      ],
    );
  }
}