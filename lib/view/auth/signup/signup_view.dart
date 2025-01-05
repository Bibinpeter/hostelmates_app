import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/routes/routes.dart';
import 'package:project/view/auth/signup/signup_controller.dart';
import 'package:project/widgets/customtextfield/customtextfield.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
     final SignupController controller = Get.find();

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/hostelLogo.jpg',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ).animate(
                        effects: [
                          const ShimmerEffect(
                            color: Colors.white,
                            duration: Duration(milliseconds: 1500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "SIGNUP",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 170),
                  FadeInDown( 
                    child: CustomText_FormField(
                      controller: controller.firstNameController,
                      type: TextInputType.name,
                      prefixIcon: Icons.person,
                      hintText: "Enter First name.",
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInRight(
                    child: CustomText_FormField(
                      controller: controller.emailController,
                      type: TextInputType.emailAddress,
                      prefixIcon: Icons.email_rounded,
                      hintText: "Enter email id.",
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    child: CustomText_FormField(
                      controller: controller.passwordController,
                      type: TextInputType.visiblePassword,
                      prefixIcon: Icons.password_rounded,
                      hintText: "Enter password(Digits).",
                    ),
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed:(){
                      controller.signup();
                    } ,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      shape: RoundedRectangleBorder( 
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                    child: const Text(
                      "SIGNUP",
                      style: TextStyle(letterSpacing: 2),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "I have already an account",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.LogIn);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Login",
                            style: GoogleFonts.poppins(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
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
