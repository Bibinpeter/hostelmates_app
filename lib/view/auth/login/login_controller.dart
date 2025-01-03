// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/routes/routes.dart';
import 'package:project/service/emailauth/authentication.dart';
import 'package:project/service/authservice/googleauth/google_auth.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isPhoneLoading = false.obs;
  var verificationId = ''.obs;
  var emailController = TextEditingController();
  var otpController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final EmailAuthMethod _authMethod = EmailAuthMethod();
  final GoogleAuth _googleAuth = GoogleAuth();

  // Function to login with email and password
  Future<void> EmailLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        colorText: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isLoading(true);
      String res =
          await _authMethod.loginUser(email: email, password: password);

      if (res == "success") {
        isLoading(false);
        Get.snackbar(
          "Success",
          "Login successful",
          colorText: Colors.green,
          snackPosition: SnackPosition.TOP,
        );
        Get.offNamed(AppRoutes.Hotelid);
      } else {
        isLoading(false);
        Get.snackbar(
          "Error",
          res,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
        );
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar(
        "Error",
        "Login failed: $e",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
    } finally {
      emailController.clear();
      passwordController.clear();
    }
  }

  // Function to sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      await _googleAuth.signInWithGoogle();
      Get.offNamed(AppRoutes.Hotelid);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to sign in: $e",
        duration: const Duration(seconds: 15),
        colorText: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Function to log out of Google account
  Future<void> googleSignOut() async {
    try {
      await _googleAuth.googleSignOut();
      Get.snackbar("Success", "Logged out successfully!",
          snackPosition: SnackPosition.TOP);
      Get.offNamed(AppRoutes.LogIn);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to sign out: $e",
        colorText: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Function to send password reset email
  Future<void> sendPasswordResetEmail(BuildContext context) async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your email",
        colorText: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Success",
        "Password reset email sent! Check your inbox.",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.green,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to send password reset email: $e",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
    }
  }

  void showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Forgot Your Password?",
                  style: TextStyle(color: Colors.white),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Enter your email",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.white.withOpacity(0.2),
                    ),
                  ),
                  onPressed: () {
                    sendPasswordResetEmail(context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Send",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showPhoneAuthenticationDialog(BuildContext context) {
    Get.dialog(
      AlertDialog( 
        backgroundColor: Colors.black,
        title: const Text(
          'Phone Authentication',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           TextField(
  controller: phoneController,
  keyboardType: TextInputType.phone,
  style: const TextStyle(color: Colors.white), 
  decoration: const InputDecoration(
    labelText: 'Enter your phone number',
    hintText: '+916282423212',
    labelStyle: TextStyle(color: Colors.blueGrey),  
    hintStyle: TextStyle(color: Colors.grey),       
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueGrey),  
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),  
    ),
  ),
),

            const SizedBox(height: 20),
            Obx(() => isPhoneLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.white.withOpacity(0.2),
                      ),
                    ),
                    onPressed: () async {
                      final phone = phoneController.text.trim();
                      if (phone.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please enter a valid phone number",
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: Colors.red,
                        );
                        return;
                      }
                      isPhoneLoading(true);
                      try {
                        await auth.verifyPhoneNumber(
                          phoneNumber: phone,
                          verificationCompleted: (credential) async {
                            await auth.signInWithCredential(credential);
                            isPhoneLoading(false);
                            Get.snackbar(
                              "Success",
                              "Phone authentication completed!",
                              snackPosition: SnackPosition.TOP,
                              colorText: Colors.green,
                            );
                          },
                          verificationFailed: (error) {
                            isPhoneLoading(false);
                            Get.snackbar(
                              "Error",
                              error.message ?? "Phone verification failed.",
                              snackPosition: SnackPosition.TOP,
                              colorText: Colors.red,
                            );
                          },
                          codeSent: (verificationId, resendToken) {
                            isPhoneLoading(false);
                            this.verificationId.value = verificationId;
                            Get.toNamed(AppRoutes.otpview,
                                arguments: verificationId);
                          },
                          codeAutoRetrievalTimeout: (verificationId) {
                            this.verificationId.value = verificationId;
                          },
                        );
                      } catch (e) {
                        isPhoneLoading(false);
                        Get.snackbar(
                          "Error",
                          "Failed to send verification code: $e",
                          snackPosition: SnackPosition.TOP,
                          colorText: Colors.red,
                        );
                      }
                    },
                    child: const Text(
                      "Send Code",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel',
             style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

//    OTPverification
  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();

    if (otp.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter the OTP",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
      return;
    }

    try {
      isLoading(true);

      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );

      await auth.signInWithCredential(credential);

      isLoading(false);
      Get.offNamed(AppRoutes.Hotelid);
    } catch (e) {
      isLoading(false);
      Get.snackbar(
        "Error",
        "OTP verification failed: $e",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
    }
  }
}
