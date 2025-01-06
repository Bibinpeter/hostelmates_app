import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  final String uid;
  final String roomNumber;
  final String userName;
  final String leaveFrom;
  final String leaveTo;
  final String date;
  final String type; // "Leave Notification" or "Food Notification"
  final String meal; // For food notifications
  final Timestamp timestamp;

  HistoryModel({
    required this.uid,
    required this.roomNumber,
    required this.userName,
    required this.leaveFrom,
    required this.leaveTo,
    required this.date,
    required this.type,
    required this.meal,
    required this.timestamp,
  });

  factory HistoryModel.fromMap(Map<String, dynamic> data) {
    return HistoryModel(
      uid: data['uid'] ?? '',
      roomNumber: data['roomNumber'] ?? '',
      userName: data['userName'] ?? '',
      leaveFrom: data['leaveFrom']?? '', // Format date if needed
      leaveTo: data['leaveTo']?? '', // Format date if needed
      date: data['date'] ?? '',
      type: data['type'] ?? '',
      meal: data['meal'] ?? '', // For food notifications
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
