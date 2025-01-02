import 'package:get/get.dart';

class HomeController extends GetxController {
  // Reactive greeting message
  final greetingMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    _setGreetingMessage();
  }

  void _setGreetingMessage() {
    final currentHour = DateTime.now().hour;

    if (currentHour >= 5 && currentHour < 12) {
      greetingMessage.value = "Good Morning";
    } else if (currentHour >= 12 && currentHour < 17) {
      greetingMessage.value = "Good Afternoon";
    } else if (currentHour >= 17 && currentHour < 21) {
      greetingMessage.value = "Good Evening";
    } else {
      greetingMessage.value = "Good Night";
    }
  }
}
