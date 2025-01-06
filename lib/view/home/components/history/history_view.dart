import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/view/home/components/history/history_controller.dart';

class HistoryView extends StatelessWidget {
  final HistoryController historyController = Get.put(HistoryController());

  HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "History",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Obx(() {
        if (historyController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (historyController.notifications.isEmpty) {
          return const Center(
            child: Text(
              "No notifications found.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: historyController.notifications.length,
          itemBuilder: (context, index) {
            final notification = historyController.notifications[index];

            // Set the card color based on the notification type
            Color cardColor;
            if (notification.type == "Leave Notification") {
              cardColor = Colors.greenAccent.withOpacity(0.3); // Dark Green for Leave Notification
            } else if (notification.type == "Food Notification") {
              cardColor = Colors.blue.withOpacity(0.3); // Light Blue for Food Notification
            } else {
              cardColor = Colors.grey[850]!; // Default dark grey for other notifications
            }

            return FadeInDownBig( 
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 4,
                color: cardColor, // Dynamically set card color
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.type,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Room Number Row
                      Row(
                        children: [
                          const Icon(
                            Icons.room_service,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Room Number: ${notification.roomNumber}",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Leave Notification details
                      if (notification.type == "Leave Notification")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Leave From: ${notification.leaveFrom}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Leave To: ${notification.leaveTo}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      // Food Notification details
                      if (notification.type == "Food Notification")
                        Row(
                          children: [
                            const Icon(
                              Icons.food_bank_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Meal: ${notification.meal}",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 8),
                      // Only display the date if it's not a Leave Notification
                      if (notification.type != "Leave Notification")
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Date: ${notification.date}",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 8),
                      // Name Row
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Name: ${notification.userName}",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
