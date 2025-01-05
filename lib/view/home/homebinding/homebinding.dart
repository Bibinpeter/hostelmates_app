import 'package:get/get.dart';
import 'package:project/view/home/components/announcement/ann_controller.dart';
import 'package:project/view/home/components/foodmenu/foodmenu_controller.dart';
import 'package:project/view/home/components/history/history_controller.dart';
import 'package:project/view/home/components/ksrtc/ksrtc_controller.dart';
import 'package:project/view/home/components/notification/notification_controller.dart';
import 'package:project/view/home/components/notify/notify_controller.dart';
import 'package:project/view/home/components/profile/profile_controller.dart';
import 'package:project/view/home/components/rules/rules_controller.dart';
import 'package:project/view/home/components/settings/ssettings_controller.dart';
import 'package:project/view/home/homecontroller/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<NotifyController>(() => NotifyController());
    Get.lazyPut<RulesController>(() => RulesController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<FoodmenuController>(() => FoodmenuController());
    Get.lazyPut<AnnController>(() => AnnController());
    Get.lazyPut<HistoryController>(() => HistoryController());
    Get.lazyPut<KsrtcController>(() => KsrtcController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
