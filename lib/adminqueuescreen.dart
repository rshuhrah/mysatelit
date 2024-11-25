import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:mysatelit/drawer.dart';
import 'package:mysatelit/queue.dart';


void main() {
  runApp(MyApp());
}

// Replace with your credentials file path
const String _credentialsFilePath = 'assets/credentials.json';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Queue Management',
      initialRoute: '/',
      routes: {
        '/': (context) => VisitorQueueScreen(),
        '/admin': (context) => AdminQueueScreen(),
      },
    );
  }
}

Future<Map<String, dynamic>> loadCredentials() async {
  String jsonString = await rootBundle.loadString('assets/credentials.json');
  return json.decode(jsonString);
}

class AdminQueueScreen extends StatefulWidget {
  const AdminQueueScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminQueueScreenState createState() => _AdminQueueScreenState();
}

class _AdminQueueScreenState extends State<AdminQueueScreen> {
  List<String> visitorNames = []; //Controller for the name input 
  List<int> queueNumbers = [];
  int nextNumber = 1;
  int? currentVisitorNumber;
  final TextEditingController nameController = TextEditingController();

    // Function to format the date and time
  String formatDateTime() {
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy hh:mm:ss a');
    return formatter.format(now);
  }
 

  void addVisitorToQueue() {
    if (nameController.text.isNotEmpty) {
      setState(() {
        queueNumbers.add(nextNumber);
        visitorNames.add(nameController.text); // Save to Google Sheets when a visitor is added
        saveToGoogleSheets(nextNumber, nameController.text);
        nextNumber++;
        nameController.clear(); // Clear the text field after adding
      });
    } else {
      // Show an error if the name field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a visitor name')),
      );
    }
  }

  void callNextVisitor() {
    if (queueNumbers.isNotEmpty) {
      setState(() {
        currentVisitorNumber = queueNumbers.removeAt(0);
      });
    }
  }

  Future<void> saveToGoogleSheets(int visitorNumber, String visitorName) async {
    // Load credentials from JSON file
    String jsonString = await rootBundle.loadString(_credentialsFilePath);
    var jsonCredentials = json.decode(jsonString);
    

    // Create an authenticated client
    var client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(jsonCredentials),
      [sheets.SheetsApi.spreadsheetsScope],
    );

    var sheetsApi = sheets.SheetsApi(client);

    // Specify your spreadsheet ID and range
    var spreadsheetId = '1ckgOMQ0IaJawRCPgp3aswt_KS7nGkO1f2kWyHiGctDk';
    var range = 'Sheet2!A:C'; // Store data in Sheet2 (columns A, B, C)

    // Get the current date and time
     String formattedDateTime = formatDateTime(); // ISO 8601 format

    // Create the row data with visitor number, name, and date/time
    var rowData = sheets.ValueRange.fromJson({
      'values': [
        [visitorNumber, visitorName, formattedDateTime], // Store visitor number, name, and date/time
      ],
    });

    // Append the data to the sheet
    await sheetsApi.spreadsheets.values.append(
      rowData,
      spreadsheetId,
      range,
      valueInputOption: 'RAW',
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Queue Management'),
      // You can also add an icon button to open the drawer if needed
      actions: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer(); // Open drawer programmatically
          },
        ),
      ],
    ),
    drawer: AppDrawer(),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (currentVisitorNumber != null)
            Text(
              'Current Visitor Number: $currentVisitorNumber',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          SizedBox(height: 20),
          Text(
            'Next Visitor Number: $nextNumber',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Nama Pelawat',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Visitor Number', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Visitor Name', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: List<DataRow>.generate(queueNumbers.length, (index) {
                return DataRow(cells: [
                  DataCell(Text(queueNumbers[index].toString().padLeft(4, '0'))),
                  DataCell(Text(visitorNames[index])),
                  DataCell(Text('Waiting Next')),
                ]);
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: addVisitorToQueue,
                child: Text('Add Visitor to Queue'),
              ),
              ElevatedButton(
                onPressed: callNextVisitor,
                child: Text('Call Next Visitor'),
              ),
            ],
          ),
        ],
      ),
    ),
    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Visitor List'),
        BottomNavigationBarItem(icon: Icon(Icons.question_answer), label: 'Questions'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointments'),
      ],
      currentIndex: 0,
      onTap: (index) {
        // Handle navigation based on the index
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/visitorList');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/questions');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/appointments');
            break;
        }
      },
    ),
  );
}
}