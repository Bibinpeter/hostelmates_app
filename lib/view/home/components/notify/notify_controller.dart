import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/view/auth/hostelid_auth/hotelid_controller.dart';
import 'package:project/view/auth/signup/signup_controller.dart';

class NotifyController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth fireAuth = FirebaseAuth.instance;

  // Leave Notification Controllers
  final TextEditingController roomNumberController = TextEditingController();
  final TextEditingController leaveFromController = TextEditingController();
  final TextEditingController leaveToController = TextEditingController();

  // Food Notification Controllers
  final TextEditingController foodroomNumberController = TextEditingController();
  final TextEditingController dateselect = TextEditingController();
  final RxString selectedMeal = 'Breakfast'.obs;
   final SignupController signupController =Get.put(SignupController());
    final user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    roomNumberController.dispose();
    leaveFromController.dispose();
    leaveToController.dispose();
    foodroomNumberController.dispose();
    dateselect.dispose();
    tabController.dispose();
    super.onClose();
  }

  Future<void> pickDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      controller.text = "${pickedDate.toLocal()}".split(' ')[0];
    }
  }

  Future<void> sendLeaveNotification( ) async {
    String? hostelId = await HostelidController().getVerifiedHostelId();
    String roomNumber = roomNumberController.text.trim();
    String leaveFrom = leaveFromController.text.trim();
    String leaveTo = leaveToController.text.trim();
    String uid = user?.uid??"";

   String userName = FirebaseAuth.instance.currentUser?.displayName ?? signupController.firstName.value;
    if (roomNumber.isEmpty || leaveFrom.isEmpty || leaveTo.isEmpty) {
      Get.snackbar(
        "Error",
        "All fields are required",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
      return;
    }

    try {
      print("Sending Leave Notification:");
      print("Hostel ID: $hostelId");
      print("Room Number: $roomNumber");
      print("Leave From: $leaveFrom");
      print("Leave To: $leaveTo");
      print("name:$userName");
       print("uid:$uid");
      await firestore
          .collection('Hostels') .doc(hostelId)
          .collection('LeaveNotifications')
          .add({
            'uid':uid,
        'roomNumber': roomNumber,
        'leaveFrom': leaveFrom,
        'leaveTo': leaveTo,
         'userName': userName,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Get.snackbar(
        "Success",
        "Leave notification sent",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.green,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to send leave notification: $e",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
    }
  }

  Future<void> sendFoodNotification( ) async {
    String? hostelId = await HostelidController().getVerifiedHostelId();

    String roomNumber = foodroomNumberController.text.trim();
    String meal = selectedMeal.value;
    String date = dateselect.text.trim();
    String userName = FirebaseAuth.instance.currentUser?.displayName ??  signupController.firstName.value;
        String uid = user?.uid??"";

    if (roomNumber.isEmpty || date.isEmpty) {
      Get.snackbar( 
        "Error",
        "All fields are required",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
      return;
    }

    try {
      print("Sending Food Notification:");
      print("Hostel ID: $hostelId");
      print("Room Number: $roomNumber");
      print("Meal: $meal");
      print("Date: $date");
      print("name:$userName");
     print("uid:$uid");

      await firestore
          .collection('Hostels')
          .doc(hostelId)  
          .collection('FoodNotifications')
          .add({
            'uid':uid,
        'roomNumber': roomNumber,
        'meal': meal,
        'date': date,
       'userName': userName,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Get.snackbar(
        "Success",
        "Food notification sent",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.green,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to send food notification: $e",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
    }
  }
}