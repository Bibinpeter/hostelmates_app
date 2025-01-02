import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/routes/routes.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () { 
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Get.offNamed(AppRoutes.HomeView); 
      } else {
        Get.offNamed(AppRoutes.LogIn);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Logo
              FadeInLeftBig(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/hostelLogo.jpg',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Animated Text
              FadeInRightBig(
                child: const Text(
                  "Hostel Mate",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
