

class Contact {
  String name;
  String email;
  String mobile;
  String feedback;
  DateTime datetime;

  
  Contact({
    required this.name,
    required this.email,
    required this.mobile,
    required this.feedback, 
    required this.datetime,
  });

  // Convert Contact object to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'mobile': mobile,
      'feedback': feedback,
      'dateTimeColumn': datetime.toIso8601String(), // Convert to String for JSON
    };
  }
  //static Contact fromJson(Map<String, dynamic> json) {
    //return Contact(
      //name: json['name'],
      //email: json['email'],
      //mobile: json['mobile'],
      //feedback: json['feedback'],
      //dateTimeColumn: DateTime.parse(json['dateTimeColumn']),
    //);
  //}
  // Create a Contact object from JSON
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      feedback: json['feedback'],
      datetime: DateTime.parse(json['dateTimeColumn']), // Parse the String back to DateTime
    );
  }
}
