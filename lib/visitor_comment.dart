import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:intl/intl.dart'; // Import intl for date formatting
import 'package:http/http.dart' as http;

class VisitorComment extends StatefulWidget {
  const VisitorComment({super.key});

  @override
  _VisitorCommentState createState() => _VisitorCommentState();
}

class _VisitorCommentState extends State<VisitorComment> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _submittedComment = '';
  String _submittedEmail = ''; // New variable for submitted email

  // Replace with your actual spreadsheet ID and range
  final String spreadsheetId = '1ckgOMQ0IaJawRCPgp3aswt_KS7nGkO1f2kWyHiGctDk';
  final String range = 'Sheet1!A:D'; // Adjust the range to include auto number

  Future<void> _appendCommentToSheet(String comment, String email) async {
    final jsonString = await rootBundle.loadString('assets/credentials.json');

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(jsonString),
      [sheets.SheetsApi.spreadsheetsScope],
    );

    final sheetsApi = sheets.SheetsApi(client);

    // Get the current date and time
    String currentDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    // Fetch the last entry to determine the next auto number
    int autoNumber = await _fetchLastAutoNumber(sheetsApi);

    final valueRange = sheets.ValueRange.fromJson({
      'values': [
        [autoNumber + 1, currentDateTime, comment, email] // Adding auto number, timestamp, and comment
      ],
    });

    await sheetsApi.spreadsheets.values.append(
      valueRange,
      spreadsheetId,
      range,
      valueInputOption: 'RAW',
    );

    client.close();
  }

  Future<int> _fetchLastAutoNumber(sheets.SheetsApi sheetsApi) async {
    final response = await sheetsApi.spreadsheets.values.get(spreadsheetId, range);
    final values = response.values;

    // Check if there's any data
    if (values != null && values.isNotEmpty) {
      // The first column contains the auto number, get the last one
      return int.tryParse(values.last[0].toString()) ?? 0; // Return 0 if there's an error
    }

    return 0; // If there's no data, start from 0
  }

  void _submitComment() async {
  final comment = _commentController.text;
  final email = _emailController.text;

  // Email validation regex
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  if (email.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Email cannot be empty')),
    );
    return;
  } else if (!emailRegex.hasMatch(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please enter a valid email address')),
    );
    return;
  }

  if (comment.isNotEmpty) {
    await _appendCommentToSheet(comment, email);
    await _sendEmailNotification(email, comment);

    setState(() {
        _submittedComment = comment; 
        _submittedEmail = email; // Store the submitted email
        _commentController.clear(); 
        _emailController.clear(); 
    });

    print('Comment submitted: $_submittedComment from email: $_submittedEmail');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Comment submitted: "$comment" from email: $email')),
    );
  } else {
    print("Comment is empty"); // Debugging line
  }
}

  Future<void> _sendEmailNotification(String email, String comment) async {
  final response = await http.post(
    Uri.parse('http://192.168.0.152:3000/send-email'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'comment': comment}),
  );

   if (response.statusCode == 200) {
    print('Email sent successfully');
  } else {
    print('Failed to send email: ${response.body}');
    throw Exception('Failed to send email');
  }
}

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Visitor Comment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Masukkan email anda disini',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 5),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Masukkan komen anda disini',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submitComment,
              child: Text('Submit Comment'),
            ),
            SizedBox(height: 10),
            if (_submittedComment.isNotEmpty) 
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Komen anda: $_submittedComment',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Dari email: $_submittedEmail',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Terima kasih kerana mengunjungi Pejabat Satelit.\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Komen anda telah direkodkan untuk penambaikan kualiti perkhidmatan.',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Tarkh: ${DateFormat('dd-MM-yyyy hh:mm:ss a').format(DateTime.now())}',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}