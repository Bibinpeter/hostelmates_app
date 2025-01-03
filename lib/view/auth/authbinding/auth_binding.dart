import 'package:get/get.dart';
import 'package:project/view/auth/hostelid_auth/hotelid_controller.dart';
import 'package:project/view/auth/login/login_controller.dart';
import 'package:project/view/auth/signup/signup_controller.dart';

 
class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostelidController>(() => HostelidController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SignupController>(() => SignupController());
     Get.lazyPut<HostelidController>(() => HostelidController());

  }
}
