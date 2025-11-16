import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/authentication/view/forgot_password.dart';
import 'package:myshetribe/screens/authentication/view/signup_screen.dart';
import 'package:myshetribe/screens/verifications/view/verification_pending.dart';
import 'package:myshetribe/screens/verifications/view/verification_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  // Login Title
                  Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const  Color(0xFF3A3A3A),
                    ),
                  ),
                    const SizedBox(height: 29),
               Container(
                 height: 400,
                   margin: const EdgeInsets.symmetric(horizontal: 19),
                      color: Color(0xffFe9cb4),
                  child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(children: [
                     const SizedBox(height: 22),
                     // Email Field
                    _buildTextField(
                      controller: _emailController,
                      hintText: 'Enter Email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 22),
                    // Password Field
                    _buildTextField(
                      controller: _passwordController,
                      hintText: 'Enter Password',
                      icon: Icons.lock,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black, // Change from Colors.grey to Colors.black
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                        },
                        child: Text(
                          'Forgot Password ?',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFF2C2C2C),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                     const SizedBox(height: 12),
                    Image.asset("assets/icons/login_image.png",height: 164,),
                     const SizedBox(height: 12),
                    // const SizedBox(height: 30),
                    // // Partnership Banner
                    // Container(
                    //   width: double.infinity,
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 20,
                    //     vertical: 16,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xFFD4A574),
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   child: Text(
                    //     'Check out our Top Partnership\nOffers & Discounts',
                    //     textAlign: TextAlign.center,
                    //     style: GoogleFonts.poppins(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w500,
                    //       color: const Color(0xFF2C2C2C),
                    //     ),
                    //   ),
                    // ),
                    //  const SizedBox(height: 20),
                    // Spacer(),
                       Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment: CrossAxisAlignment.end,
                                           children: [
                                             Text(
                        "Don't have an account? ",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xFF2C2C2C),
                        ),
                                             ),
                                             GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                                             ),
                                           ],
                                         ),
                                         const SizedBox(height: 4),
                                 ],),
                                 
                ),),
                   const SizedBox(height: 29),
                  // Login Button
                  SizedBox(
                     width: MediaQuery.of(context).size.width*0.75,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationScreen()));
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
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 45),
                  // Don't have account
               
                  // const SizedBox(height: 30),
                ],
              ),
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
            // Decorative elements (butterfly and UAE)
            Text(
              '🦋',
              style: const TextStyle(fontSize: 24),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
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
          suffixIconColor: Colors.black,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
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