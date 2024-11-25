import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  Future<void> saveDataToSheet(String name, String email, String mobile, String feedback, String currentDateTime) async {
    final String scriptURL = 'https://script.google.com/macros/s/AKfycbxnkRRhgQ1S4d_0oz1HaRyLoyeH1G_bFx6au6WIm4WA8dSpH0lApWcQ5UhRe-Wh7M9Tgw/exec';

    // Encode parameters
    String encodedName = Uri.encodeComponent(name);
    String encodedEmail = Uri.encodeComponent(email);
    String encodedMobile = Uri.encodeComponent(mobile);
    String encodedFeedback = Uri.encodeComponent(feedback);
    String encodedCurrentDateTime = Uri.encodeComponent(currentDateTime);

    final String url = '$scriptURL?name=$encodedName&email=$encodedEmail&mobile=$encodedMobile&feedback=$encodedFeedback&currentDateTime=$encodedCurrentDateTime';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      );

      if (response.statusCode == 200) {
        print('Data submitted successfully!');
      } else {
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feedback Form')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: mobileController,
              decoration: InputDecoration(labelText: 'Mobile'),
            ),
            TextField(
              controller: feedbackController,
              decoration: InputDecoration(labelText: 'Feedback'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String email = emailController.text;
                String mobile = mobileController.text;
                String feedback = feedbackController.text;
                String currentDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

                // Call the method to save data
                saveDataToSheet(name, email, mobile, feedback, currentDateTime);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
