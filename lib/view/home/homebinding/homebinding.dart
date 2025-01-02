import 'package:get/get.dart';
import 'package:project/view/auth/hostelid_auth/hotelid_controller.dart';
import 'package:project/view/home/homeview/home_controller.dart';

 
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
     Get.lazyPut<HostelidController>(() => HostelidController());
  }
}
