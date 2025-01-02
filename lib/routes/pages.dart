import 'package:get/get.dart';
import 'package:project/routes/routes.dart';
import 'package:project/service/authservice/phoneauth/otp_view.dart';
import 'package:project/view/auth/authbinding/auth_binding.dart';
import 'package:project/view/auth/hostelid_auth/hostelid_view.dart';
import 'package:project/view/auth/login/login_view.dart';
import 'package:project/view/auth/signup/signup_view.dart';
import 'package:project/view/auth/splah/splash_view.dart';
import 'package:project/view/home/homebinding/homebinding.dart';
import 'package:project/view/home/homeview/home_view.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.Splash,
      page: () => const SplashView(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.LogIn,
      page: () => const LoginView(),
      transition: Transition.rightToLeftWithFade,
      binding: AuthBinding(),
    ),
   GetPage(
  name: AppRoutes.otpview,
  page: () => OTPScreen(
    verificationId: Get.arguments as String,
  ),
  transition: Transition.rightToLeftWithFade,
  binding: HomeBinding(),
),

    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupView(),
      transition: Transition.rightToLeftWithFade,
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.Hotelid,
      page: () =>   HostelidView(),
      transition: Transition.rightToLeftWithFade,
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.HomeView,
      page: () =>   HomeView(),
      transition: Transition.rightToLeftWithFade,
      binding: HomeBinding(),
    ),
  ];
}
