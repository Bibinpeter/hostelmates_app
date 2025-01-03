import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HostelidController extends GetxController {
  var hostelIdController = TextEditingController();
  var firestore = FirebaseFirestore.instance;

  RxString verifiedHostelId = "".obs;
  RxString place = "".obs;
  RxString name = "".obs;
  RxString accomodation = "".obs;
  RxString highlights = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadHostelDataFromPrefs();  
  }

  @override
  void onClose() {
    hostelIdController.dispose();
    super.onClose();
  }

  // Load hostel data from SharedPreferences
  Future<void> loadHostelDataFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    place.value = prefs.getString('place') ?? "";
    name.value = prefs.getString('name') ?? "";
    accomodation.value = prefs.getString('accomodation') ?? "";
    highlights.value = prefs.getString('highlights') ?? "";
  }

  /// Verifies the hostel ID by fetching data from Firestore and stores it persistently
  Future<void> verifyHostelId(BuildContext context) async {
    final String hostelId = hostelIdController.text.trim();

    if (hostelId.isEmpty) {
      _showError("Please enter a hostel ID");
      return;
    }

    try {
      final DocumentSnapshot doc =
          await firestore.collection('Hostels').doc(hostelId).get();

      if (doc.exists) {
        // Extract data from Firestore
        place.value = doc['place'] ?? "";
        name.value = doc['name'] ?? "";
        accomodation.value = doc['accomodation'] ?? "";
        highlights.value = doc['highlights'] ?? "";
        await _saveToSharedPrefs();

        verifiedHostelId.value = hostelId;

        Get.offNamed(AppRoutes.HomeView);
      } else {
        _showError("Invalid Hostel ID");
      }
    } catch (e) {
      _showError("Failed to verify Hostel ID: $e");
    } finally {
      hostelIdController.clear(); // Clear the text field
    }
  }

 
  Future<void> _saveToSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('place', place.value);
    await prefs.setString('name', name.value);
    await prefs.setString('accomodation', accomodation.value);
    await prefs.setString('highlights', highlights.value);
    await prefs.setString('verifiedHostelId', verifiedHostelId.value);
  }

 
  void _showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.red,
    );
  }
}
