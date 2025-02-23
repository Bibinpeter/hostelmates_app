import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/service/authservice/emailauth/email_auth.dart';
import 'package:project/view/auth/signup/signup_controller.dart';
import 'package:project/view/home/homecontroller/home_controller.dart';

class Header extends StatelessWidget {
  Header({
    super.key,
    required this.Fireauth,
    required this.homeController,
  });

  final FirebaseAuth Fireauth;
  final HomeController homeController;
  final EmailAuthMethod Emailauth = EmailAuthMethod();
  final SignupController signupController =Get.put(SignupController());

@override
Widget build(BuildContext context) {
  // Ensure the widget handles null values gracefully
  final user = Fireauth.currentUser;

  return Obx(() {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade200, Colors.blue.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 38),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: FadeInRightBig(
                delay: const Duration(seconds: 1),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 23,
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : null,
                      child: user?.photoURL == null
                          ? const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(width: 6),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Hi..\n${user?.displayName ?? signupController.firstName.value}",
                        style: GoogleFonts.mochiyPopOne(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => _showLogoutDialog(context),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          const Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 30,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Logout",
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15),
              child: FadeInUp(
                delay: const Duration(seconds: 1),
                child: Text(
                  homeController.greetingMessage(),
                  style: GoogleFonts.mochiyPopOne(
                    fontSize: 9,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  });
}


  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text("Do you really want to log out?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Emailauth.signOut();
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
