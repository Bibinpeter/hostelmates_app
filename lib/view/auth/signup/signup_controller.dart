import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/routes/routes.dart';
import 'package:project/service/authservice/emailauth/email_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  // final UserController userController = Get.put(UserController());
  var firstNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final EmailAuthMethod _authMethod = EmailAuthMethod();

  var isLoading = false.obs;
  var firstName = "".obs;


  @override
  void onInit() {
    super.onInit();
   loadFirstName(); 
  }
  // Separate function to load the first name from SharedPreferences
  Future<void> loadFirstName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedFirstName = prefs.getString('firstName');
    if (savedFirstName != null) {
      firstName.value = savedFirstName;
    }
  }

 Future<void> signup() async {
  final enteredFirstName = firstNameController.text.trim();
  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  // Validate inputs
  if (enteredFirstName.isEmpty || email.isEmpty || password.isEmpty) {
    Get.snackbar(
      'Error',
      'Please fill all fields',
      colorText: Colors.red,
      snackPosition: SnackPosition.TOP,
    );
    return;
  }

  try {
    isLoading(true);

    // Update first name observable
    firstName.value = enteredFirstName;

    // Signup the user and get the user ID
    String userId = await _authMethod.signupUser(
      name: enteredFirstName,
      email: email,
      password: password,
    );

    if (userId.isNotEmpty) {
      isLoading(false);

      // Save user ID in UserController
     // userController.setUserId(userId);
      print("Userid_in signupcontroller:::::::::::::::::::::$userId");
      // Save first name to SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('firstName', enteredFirstName);

      // Display success message
      Get.snackbar(
        'Success',
        'Signup successful',
        backgroundColor: Colors.black.withOpacity(0.3),
        colorText: Colors.green,
        snackPosition: SnackPosition.TOP,
      );

      // Navigate to next screen
      Get.offNamed(AppRoutes.Hotelid);
    } else {
      isLoading(false);
      Get.snackbar(
        'Error',
        'Signup failed: Unable to retrieve user ID',
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } catch (e) {
    isLoading(false);
    Get.snackbar(
      'Error',
      'Signup failed: $e',
      colorText: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

  @override
  void onClose() {
    firstNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
