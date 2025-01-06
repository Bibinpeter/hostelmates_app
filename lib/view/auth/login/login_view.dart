import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project/routes/routes.dart';
import 'package:project/service/authservice/googleauth/google_auth.dart';
import 'package:project/view/auth/login/login_controller.dart';
import 'package:project/widgets/customtextfield/customtextfield.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
      final LoginController loginController = Get.find();
      final GoogleAuth _googleAuth=GoogleAuth();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/hostellogin.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.1), Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/hostelLogo.jpg',
                        height: 100,
                        width: 100,
                        fit: BoxFit 
                            .cover,  
                      ).animate(
                        effects: [
                          const ShimmerEffect(
                            color: Colors.white,
                            duration: Duration(
                                milliseconds: 1500),  
                          ),
                        ],
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "LOGIN",
                      style: GoogleFonts.poppins(
                        letterSpacing: 2,
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 180,
                  ),
                  FadeInDown(
                    child:  
                     CustomText_FormField(
                        type:TextInputType.emailAddress,
                      controller: loginController.emailController,
                      prefixIcon: Icons.email_rounded,
                      hintText: "Enter email id.",
                      onSubmitted: (p0) {
                        
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    child:    
                    CustomText_FormField(
                      type:TextInputType.name,
                      controller: loginController.passwordController,
                      hintText: "Enter password(Digits).",
                      prefixIcon: Icons.password_rounded,
                      onSubmitted: (p0) {
                        
                      },
                    ),
                  ),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () { 
                     loginController.showForgotPasswordDialog(context);
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ), 
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      loginController.EmailLogin(); 
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                    ),
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(letterSpacing: 2),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Divider with OR
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'OR',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Google Sign-In Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [ 
                      FadeInLeft(child: GestureDetector(  
                        onTap: () {
                          _googleAuth.signInWithGoogle();
                        },
                        child: Brand(Brands.google))),

                      FadeInRight(child: GestureDetector( 
                        onTap: (){
                            loginController.showPhoneAuthenticationDialog(context);
                        },
                        child: Brand(Brands.phone))),
                    ],
                  ),

                  const SizedBox(height: 30 ),
                  // Sign up text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.signup);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Signup",
                            style: GoogleFonts.poppins(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
