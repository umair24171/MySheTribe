// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:myshetribe/screens/custom_bottom_bar.dart';
// import 'package:myshetribe/screens/profile/view/profile_screen.dart';
// import 'package:myshetribe/screens/verifications/view/ai_tribe_matching.dart';
// import 'package:myshetribe/widgets/logo_header.dart';

// class WelcomeScreen extends StatelessWidget {
//   final String userName;
//   final String? userImageUrl;

//   const WelcomeScreen({
//     Key? key,
//     required this.userName,
//     this.userImageUrl,
//   }) : super(key: key);

//   @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: const Color(0xFFFFB6C8),
//     body: SafeArea(
//       child: SingleChildScrollView(  // Add this
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 0.0),
//           child: Column(
//             children: [
//                  const SizedBox(height: 20),
//               LogoHeader(),
//               const SizedBox(height: 20),
//               // Welcome Title
//               Text(
//                 'Welcome $userName',
//                 style: GoogleFonts.poppins(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                   color: const Color(0xFF2C2C2C),
//                 ),
//               ),
//                const SizedBox(height: 20),
//                // Thank you message
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: Text(
//                       'Thank you for setting your\n profile.',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: const Color(0xFF2C2C2C),
//                         height: 1.5,
//                       ),
//                     ),
//                   ),
//               const SizedBox(height: 40),
//               Container(
//                 width: MediaQuery.of(context).size.width*0.9,
//                 color: Color(0xffFe9cb4),
//                 padding: const EdgeInsets.symmetric(horizontal: 0.0),
//                 child: Container(
//                       color: Colors.white,
//                   margin: EdgeInsets.all(15),
//                  padding: const EdgeInsets.all(10),
//                   child: Column(children: [
//                     const SizedBox(height: 20),
//                     // Profile Photo
//                     Container(
//                       width: 210,
//                       height: 191,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                         image:  DecorationImage(
//                                 image: AssetImage('assets/icons/profile_Image.png'),
//                                 fit: BoxFit.cover,
//                               )
                          
//                       ),
                    
//                     ),
//                     // const SizedBox(height: 40),
                   
//                     const SizedBox(height: 20),
//                   ]),
//                 ),
//               ),
//               SizedBox(height:60), // Replace Spacer
//               // Continue Button
//               SizedBox(
//                 width: 317,
//                 height: 55,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileSetupScreen()));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     elevation: 0,
//                     backgroundColor: const Color(0xFF3A3A3A),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(0),
//                     ),
//                   ),
//                   child: Text(
//                     'Continue',
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
//   Widget _buildHeader() {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               '🦋',
//               style: const TextStyle(fontSize: 24),
//             ),
//             const SizedBox(width: 10),
//             Text(
//               'UAE',
//               style: GoogleFonts.poppins(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 5),
//         Text(
//           'MySheTribe',
//           style: GoogleFonts.poppins(
//             fontSize: 36,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             letterSpacing: 1.5,
//           ),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           'CONNECTING WOMEN,',
//           style: GoogleFonts.poppins(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.white,
//             letterSpacing: 2,
//           ),
//         ),
//         Text(
//           'CREATING COMMUNITY',
//           style: GoogleFonts.poppins(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.white,
//             letterSpacing: 2,
//           ),
//         ),
//       ],
//     );
//   }
// }