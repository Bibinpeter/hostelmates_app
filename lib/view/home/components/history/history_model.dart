class HistoryModel {
  final String type; 
  final String roomNumber;
  final String meal; 
  final String date;
  final String userName;

  HistoryModel({
    required this.type,
    required this.roomNumber,
    this.meal = "",
    required this.date,
    required this.userName,
  });

  factory HistoryModel.fromMap(Map<String, dynamic> data) {
    return HistoryModel(
      type: data['type'] ?? '',
      roomNumber: data['roomNumber'] ?? '',
      meal: data['meal'] ?? '',
      date: data['date'] ?? '',
      userName: data['userName'] ?? '',
    );
  }
}
