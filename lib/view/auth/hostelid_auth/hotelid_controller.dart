import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/routes/routes.dart';

class HostelidController extends GetxController {
  var hostelIdController = TextEditingController();
  var firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;
  RxString verifiedHostelId = "".obs;
  RxString place = "".obs;
  RxString name = "".obs;
  RxString accomodation = "".obs; // Use "accomodation" consistently.
  RxString highlights = "".obs;

  // Fetch arguments and initialize variables
  void fetchArguments() {
    final arguments = Get.arguments;
    print("arguments: $arguments");
    if (arguments != null) {
      verifiedHostelId.value = arguments['hostelId'] ?? '';
      place.value = arguments['place'] ?? 'No place available';
      name.value = arguments['name'] ?? 'No name available';
      accomodation.value = arguments['accomodation'] ?? 'will update soon'; // Consistent key name
      highlights.value = arguments['highlights'] ?? 'No highlights available';
    }
  }

  // Function to verify the hostel ID
  Future<void> verifyHostelId(BuildContext context) async {
    final String hostelId = hostelIdController.text.trim();

    if (hostelId.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a hostel ID",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Fetch document from Firestore
      final DocumentSnapshot doc = await firestore.collection('Hostels').doc(hostelId).get();

      if (doc.exists) {
        // Update values based on document data
        verifiedHostelId.value = hostelId;
        place.value = doc['place'] ?? 'No place available';
        name.value = doc['name'] ?? 'No name available';
        accomodation.value = doc['accomodation'] ?? 'will update sn'; // Consistent key name
        highlights.value = doc['highlights'] ?? 'No highlights available';

        // Navigate to the home view with arguments
        Get.offNamed(AppRoutes.HomeView, arguments: {
          'hostelId': hostelId,
          'place': place.value,
          'name': name.value,
          'accomodation': accomodation.value, // Consistent key name
          'highlights': highlights.value,
        });
      } else {
        Get.snackbar(
          "Error",
          "Invalid Hostel ID",
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to verify Hostel ID: $e",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
      hostelIdController.clear();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchArguments();
  }

  @override
  void onClose() {
    hostelIdController.dispose();
    super.onClose();
  }
}
