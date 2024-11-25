import 'package:intl/intl.dart';

class Visitor {
  final int id;
  String name;
  String email;
  String mobile;
  String message;
  DateTime datetime;
  String date; // New field for the date in 'yyyy-MM-dd' format

  Visitor({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.message,
     DateTime? datetime,
  })  : datetime = datetime ?? DateTime.now(), // Set to now if not provided
        date = DateFormat('yyyy-MM-dd').format(datetime ?? DateTime.now()); // Format the date


Map<String, dynamic> toJson() => {
    'no': id,
    'name': name,
    'email': email,
    'mobile': mobile,
    'message': message,
    'datetime': datetime.toIso8601String(), // Convert DateTime to String
    'date': date, // Add date to JSON
  };

  static Visitor fromJson(Map<String, dynamic> json) {
    return Visitor(
      id: json['no'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      message: json['message'],
      datetime: DateTime.parse(json['datetime']), // Convert String back to DateTime
    );
  }
}