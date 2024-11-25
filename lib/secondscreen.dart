
var urlscript=
{ "https://script.google.com/macros/s/AKfycbxnkRRhgQ1S4d_0oz1HaRyLoyeH1G_bFx6au6WIm4WA8dSpH0lApWcQ5UhRe-Wh7M9Tgw/exec" };


class Contact {
  String name;
  String email;
  String mobile;
  String feedback;

  Contact({
    required this.name,
    required this.email,
    required this.mobile,
    required this.feedback,
  });

 // factory Contact.fromMap(Map<String, dynamic> json) {
    //return Contact(
      //name: json['name'],
      //email: json['email'],
      //mobile: json['mobile'],
      //feedback: json['feedback'],
    //);
  //}

  factory Contact.fromJson(dynamic json) {
    return Contact(
        name: "${json['name']}",
        email: "${json['email']}",
        mobile: "${json['mobile']}",
        feedback: "${json['feedback']}",
    );
  }
    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "mobile": mobile,
        "feedback": feedback,
    };



}

