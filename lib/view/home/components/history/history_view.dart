import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/view/home/components/history/history_controller.dart';

class HistoryView extends StatelessWidget {
  final HistoryController historyController = Get.put(HistoryController());

  HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: Obx(() {
        if (historyController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (historyController.notifications.isEmpty) {
          return const Center(
            child: Text("No notifications found."),
          );
        }

        return ListView.builder(
          itemCount: historyController.notifications.length,
          itemBuilder: (context, index) {
            final notification = historyController.notifications[index];

            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.type,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text("Room Number: ${notification.roomNumber}"),
                    if (notification.type == "Food Notification")
                      Text("Meal: ${notification.meal}"),
                    Text("Date: ${notification.date}"),
                    Text("Name: ${notification.userName}"),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
