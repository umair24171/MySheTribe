import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:myshetribe/screens/authentication/view/login_screen.dart';
import 'package:myshetribe/screens/terms_condition/view/terms_condition.dart';
import 'package:myshetribe/screens/verifications/view/verification_pending.dart';
import 'package:myshetribe/screens/verifications/view/verification_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';
import 'package:myshetribe/providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureLocation = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Logo and Branding
                  LogoHeader(),
                  const SizedBox(height: 29),
                  // Sign Up Title
                  Text(
                    'Sign Up',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const   Color(0xFF3A3A3A),
                    ),
                  ),
                    const SizedBox(height: 29),
                Container(
                  height: 450,
                   margin: const EdgeInsets.symmetric(horizontal: 19),
                      color: Color(0xffFe9cb4),
                  child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(children: [
                      const SizedBox(height: 22),
                    // Full Name Field
                    _buildTextField(
                      controller: _nameController,
                      hintText: 'Enter Your Full Name',
                      icon: Icons.person,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 22),
                    // Email Field
                    _buildTextField(
                      controller: _emailController,
                      hintText: 'Enter Email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 22),
                    // Phone Number Field
                    _buildTextField(
                      controller: _phoneController,
                      hintText: 'Enter Phone Number',
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),
                     const SizedBox(height: 22),
                    // Location Field
                    _buildTextField(
                      controller: _locationController,
                      hintText: 'Enter Location (City/Country)',
                      icon: Icons.location_city,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 22),
                    // Password Field
                    _buildTextField(
                      controller: _passwordController,
                      hintText: 'Enter New Password',
                      icon: Icons.lock,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 3),
                      // Terms and Privacy
                Padding(
  padding: const EdgeInsets.symmetric(horizontal: 0),
  child: RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF2C2C2C),
      ),
      children: [
        const TextSpan(text: 'By signing up you agree to our '),
        TextSpan(
          text: 'Terms of Service',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TermsConditionsScreen(),
                ),
              );
            },
        ),
        const TextSpan(text: 'and '),
        TextSpan(
          text: 'Privacy Policy',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // Navigate to Privacy Policy screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TermsConditionsScreen(), // or PrivacyPolicyScreen()
                ),
              );
            },
        ),
      ],
    ),
  ),
),
                  // const SizedBox(height:12),
                   const SizedBox(height: 6),
                  // Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: GoogleFonts.poppins(
                           fontSize: 12,
                            fontWeight: FontWeight.w400,
                          color: const Color(0xFF2C2C2C),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                           fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                
                                    ],),
                  ),),
                   const SizedBox(height: 29),
                  // Login Button
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return SizedBox(
                         width: MediaQuery.of(context).size.width*0.75,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: authProvider.isLoading ? null : () async {
                            if (_formKey.currentState!.validate()) {
                              bool success = await authProvider.signUp(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                                fullName: _nameController.text.trim(),
                                phoneNumber: _phoneController.text.trim(),
                                city: _locationController.text.trim(),
                              );

                              if (success) {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationScreen()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(authProvider.errorMessage ?? 'Sign up failed'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xFF3A3A3A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: authProvider.isLoading
                              ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                              : Text(
                                  'Verify Identity',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  // const SizedBox(height: 15),
                  // Terms and Privacy
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 30),
                  //   child: RichText(
                  //     textAlign: TextAlign.center,
                  //     text: TextSpan(
                  //       style: GoogleFonts.poppins(
                  //         fontSize: 15,
                  //         color: const Color(0xFF2C2C2C),
                  //       ),
                  //       children: [
                  //          TextSpan(text: 'By signing up you agree to our ', style: GoogleFonts.poppins(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 15,
                  //           ),),
                  //         TextSpan(
                  //           text: 'Terms of Service\n',
                  //           style: GoogleFonts.poppins(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 15,
                  //           ),
                  //         ),
                  //         const TextSpan(text: ' and '),
                  //         TextSpan(
                  //           text: 'Privacy Policy',
                  //           style: GoogleFonts.poppins(
                  //             color: Colors.white,
                  //                fontSize: 15,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                
                
                  // const SizedBox(height: 10),
                  // // Already have account
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'Already have an account? ',
                  //       style: GoogleFonts.poppins(
                  //          fontSize: 15,
                  //         color: const Color(0xFF2C2C2C),
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  //       },
                  //       child: Text(
                  //         'Login',
                  //         style: GoogleFonts.poppins(
                  //             fontSize: 15,
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                
                
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      // height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: GoogleFonts.poppins(
          fontSize: 16,
           fontWeight: FontWeight.w500,
          color: const Color(0xFF2C2C2C),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
             fontWeight: FontWeight.w500,
            fontSize: 16,
            color: const Color(0xFF2C2C2C),
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF2C2C2C),
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          constraints: BoxConstraints(maxHeight: 55,minHeight: 55),
          fillColor: Colors.white,
          // contentPadding: const EdgeInsets.symmetric(
          //   horizontal: 0,
          //   vertical: 0,
          // ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }
}