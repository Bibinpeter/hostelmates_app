import 'package:get/get.dart';
import 'package:project/routes/routes.dart';
import 'package:project/service/authservice/phoneauth/otp_view.dart';
import 'package:project/view/auth/authbinding/auth_binding.dart';
import 'package:project/view/auth/hostelid_auth/hostelid_view.dart';
import 'package:project/view/auth/login/login_view.dart';
import 'package:project/view/auth/signup/signup_view.dart';
import 'package:project/view/auth/splah/splash_view.dart';
import 'package:project/view/home/components/announcement/ann_view.dart';
import 'package:project/view/home/components/foodmenu/foodmenu_view.dart';
import 'package:project/view/home/components/ksrtc/ksrtc_view.dart';
import 'package:project/view/home/components/notification/notification_view.dart';
import 'package:project/view/home/components/notify/notify_view.dart';
import 'package:project/view/home/components/payment/payment_view.dart';
import 'package:project/view/home/components/profile/profile_view.dart';
import 'package:project/view/home/components/rules/rules_view.dart';
import 'package:project/view/home/components/settings/settings.dart';
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
      page: () => const HostelidView(),
      transition: Transition.rightToLeftWithFade,
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.HomeView,
      page: () => HomeView(),
      transition: Transition.rightToLeftWithFade,
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.notifyview,   
      page: () =>   NotifyView(),
      transition: Transition.rightToLeftWithFade,
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.rulesView,
      page: () => RulesView(),
      transition: Transition.rightToLeftWithFade,
      binding: HomeBinding(),
    ),
    GetPage(
        name: AppRoutes.notificationsView,
        page: () => NotificationView(),
        transition: Transition.rightToLeftWithFade,
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.foodMenuView,
        page: () => FoodmenuView(),
        transition: Transition.rightToLeftWithFade,
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.announcementsView,
        page: () => AnnView(),
        transition: Transition.rightToLeftWithFade,
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.paymentView,
        page: () => PaymentView(),
        transition: Transition.rightToLeftWithFade,
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.ksrtcBookingView,
        page: () => KsrtcView(),
        transition: Transition.rightToLeftWithFade,
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.settingsView,
        page: () => settingsView(),
        transition: Transition.rightToLeftWithFade,
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.profileView,
        page: () => ProfileView(),
        transition: Transition.rightToLeftWithFade,
        binding: HomeBinding()),
  ];
}
