import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/routes/routes.dart';
import 'package:project/service/emailauth/authentication.dart';

class SignupController extends GetxController {
   var   firstNameController = TextEditingController();
   var   emailController = TextEditingController();
   var   passwordController = TextEditingController();
   final EmailAuthMethod _authMethod = EmailAuthMethod();

   var isLoading = false.obs; 
   var firstName = "".obs;    
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
      print("Before updating: ${firstName.value}");
firstName.value = enteredFirstName;
print("After updating: ${firstName.value}");
      String res = await _authMethod.signupUser(
        name: enteredFirstName,
        email: email,
        password: password,
      );
    
      if (res == "success") {
        isLoading(false);
        print("firstName--------------------$firstName");

        Get.snackbar(
          'Success',
          'Signup successful',
          colorText: Colors.green,
          snackPosition: SnackPosition.TOP,
        );
        Get.offNamed(AppRoutes.Hotelid);  
      } else {
        isLoading(false);
        Get.snackbar(
          'Error',
          res,
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
