import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project/view/auth/hostelid_auth/hotelid_controller.dart';

import 'history_model.dart';

class HistoryController extends GetxController {

  RxList<HistoryModel> notifications = <HistoryModel>[].obs;
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }


  void fetchNotifications() async {
    print("fetching historycontroller::::");
    isLoading.value = true;

    String? hostelId = await HostelidController().getVerifiedHostelId();
     print("history_hosteld $hostelId");
    if (hostelId == null || hostelId.isEmpty) {
      isLoading.value = false;
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    print("user in history::::$user");
    if (user == null) {
      print("User not logged in");
      isLoading.value = false;
      return;
    }

    String uid = user.uid;

    try {
      print("uid in history::::$uid");

     //leave notification
      final leaveSnapshots = await FirebaseFirestore.instance
          .collection('Hostels')
          .doc(hostelId)
          .collection('LeaveNotifications')
          .where('uid', isEqualTo: uid)
          .get();
    print("leaveSnapshots: ${leaveSnapshots.docs.map((doc) => doc.data()).toList()}");

      final foodSnapshots = await FirebaseFirestore.instance
          .collection('Hostels')
          .doc(hostelId)
          .collection('FoodNotifications')
          .where('uid', isEqualTo: uid)
          .get();


    print("foodSnapshots: ${foodSnapshots.docs.map((doc) => doc.data()).toList()}");
      final leaveNotifications = leaveSnapshots.docs
          .map((doc) => HistoryModel.fromMap(doc.data()..['type'] = 'Leave Notification'))
          .toList();

      final foodNotifications = foodSnapshots.docs
          .map((doc) => HistoryModel.fromMap(doc.data()..['type'] = 'Food Notification'))
          .toList();

      notifications.value = [...leaveNotifications, ...foodNotifications];
    } catch (e) {
      print("Error fetching notifications: $e");
    } finally {
      isLoading.value = false;
    }
  }

}
