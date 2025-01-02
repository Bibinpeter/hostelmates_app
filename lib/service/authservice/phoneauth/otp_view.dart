import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/view/auth/login/login_controller.dart';

class OTPScreen extends StatelessWidget {
  final String verificationId;

  OTPScreen({super.key, required this.verificationId});

  final LoginController loginController = Get.find();

   Future<void> requestSmsPermission() async {
    PermissionStatus status = await Permission.sms.request();

    if (status.isGranted) {
        Get.snackbar(
        "Permission Granted",
        "You can now proceed with OTP verification.",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.green,
      );
    } else {
       Get.snackbar(
        "Permission Denied",
        "SMS permission is required to verify OTP.",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
     loginController.verificationId.value = verificationId;  

     requestSmsPermission();

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Image.asset("assets/images/otpimage.jpg"),
              const Text(
                "OTP Verification", 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "We need to register your phone number by using a one-time OTP code verification.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: loginController.otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter OTP",
                    labelText: "OTP",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              loginController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () => loginController.verifyOtp(),
                      child: const Text(
                        "Verify OTP",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
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
