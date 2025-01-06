import 'package:get/get.dart';

class KsrtcController extends GetxController{
  var isLoadingPage = true.obs;  // Using .obs to make it observable

  void setLoadingStatus(bool status) {
    isLoadingPage.value = status; // Update the loading status
  }
}