import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/view/auth/hostelid_auth/hotelid_controller.dart';

import 'notify_controller.dart';

class NotifyView extends StatelessWidget {
  final NotifyController notifyController = Get.put(NotifyController());
  final HostelidController hostelidController = Get.put(HostelidController());

  NotifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          'Notify to hostel',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        bottom: TabBar(
          unselectedLabelColor: Colors.blueGrey,
          dividerColor: Colors.blueGrey,
          labelColor: Colors.blue,
          indicatorColor: Colors.blue,
          controller: notifyController.tabController,
          tabs: const [
            Tab(text: 'Leave Notify'),
            Tab(text: 'Food Notify'),
          ],
        ),
      ),
      body: TabBarView(
        controller: notifyController.tabController,
        children: [
          _leaveNotifyTab(),
          _foodNotifyTab(),
        ],
      ),
    );
  }

  Widget _leaveNotifyTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            FadeInDown(
              child: TextField(
                cursorColor: Colors.blue,
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                controller: notifyController.roomNumberController,
                decoration: InputDecoration(
                  labelText: 'Room Number',
                  labelStyle: const TextStyle(color: Colors.blueGrey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeInLeft(
              child: TextField(
                controller: notifyController.leaveFromController,
                readOnly: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Leave From',
                  labelStyle: const TextStyle(color: Colors.blueGrey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.date_range, color: Colors.white),
                    onPressed: () => notifyController
                        .pickDate(notifyController.leaveFromController),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeInUp(
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: notifyController.leaveToController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Leave To',
                  labelStyle: const TextStyle(color: Colors.blueGrey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                    ),
                    onPressed: () => notifyController
                        .pickDate(notifyController.leaveToController),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 52),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  notifyController.sendLeaveNotification();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                child: const Text(
                  "SEND",
                  style: TextStyle(letterSpacing: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _foodNotifyTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            FadeInDown(
              child: TextField(
                cursorColor: Colors.blue,
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.white),
                controller: notifyController.foodroomNumberController,
                decoration: InputDecoration(
                  labelText: 'Room Number',
                  labelStyle: const TextStyle(color: Colors.blueGrey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeInLeft(
              child: DropdownButtonFormField<String>(
                value: notifyController.selectedMeal.value,
                onChanged: (newValue) {
                  notifyController.selectedMeal.value = newValue!;
                },
                items: ['Breakfast', 'Lunch', 'Dinner']
                    .map((meal) => DropdownMenuItem(
                          value: meal,
                          child: Text(
                            meal,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ))
                    .toList(),
                dropdownColor: Colors.grey,
                decoration: InputDecoration(
                  labelText: 'Select Meal',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 32),
            FadeInUp(
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: notifyController.dateselect,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Select Date',
                  labelStyle: const TextStyle(color: Colors.blueGrey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month, color: Colors.white),
                    onPressed: () =>
                        notifyController.pickDate(notifyController.dateselect),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 62),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  notifyController.sendFoodNotification();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                child: const Text(
                  "SEND",
                  style: TextStyle(letterSpacing: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
