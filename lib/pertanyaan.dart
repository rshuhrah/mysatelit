import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:intl/intl.dart';
import 'package:mysatelit/models/visitor.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> loadCredentials() async {
  String jsonString = await rootBundle.loadString('assets/credentials.json');
  return json.decode(jsonString);
}

class Pertanyaan extends StatefulWidget {
  const Pertanyaan({super.key});

  @override
  State<Pertanyaan> createState() => _PertanyaanState();
}

class _PertanyaanState extends State<Pertanyaan> {
  List<Visitor> visitors = [];
  int? editingIndex; // To track which visitor is being edited
  int lastId = 0; // Initialize lastId

  /// Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
 
  final _formKey = GlobalKey<FormState>(); // Key for the form

  bool isSubmitting = false;

  // Add this method to load the last used ID
  Future<int> loadLastId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('lastId') ?? 0; // Default to 0 if no ID is found
  }

   Future<void> saveLastId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastId', id);
  }


  @override
    void initState() {
      super.initState();
      loadVisitors(); // Load visitors when the app starts
      loadLastId().then((id) {
        setState(() {
          lastId = id; // Load the last ID
        });
      });
    }


  Future<void> loadVisitors() async {
    final prefs = await SharedPreferences.getInstance();
    String? visitorsJson = prefs.getString('visitors');
    List<dynamic> visitorsList = jsonDecode(visitorsJson!);
    setState(() {
      visitors = visitorsList.map((visitor) => Visitor.fromJson(visitor)).toList();
    });
    }

  Future<void> saveVisitors() async {
    final prefs = await SharedPreferences.getInstance();
    String visitorsJson = jsonEncode(visitors.map((visitor) => visitor.toJson()).toList());
    await prefs.setString('visitors', visitorsJson);
  }
  void addVisitor() {
    if (_formKey.currentState!.validate()) {
      
       lastId++; // Increment the last ID for the new visitor
      
      Visitor newVisitor = Visitor(
        id: lastId, // Set the auto-generated ID
        name: nameController.text, 
        email: emailController.text,
        mobile: mobileController.text,
        message: messageController.text,
        datetime: DateTime.now(), // Set datetime to now
    );

      setState(() {
      if (editingIndex != null) {
        // Update existing visitor
        visitors[editingIndex!] = newVisitor;
        editingIndex = null; // Clear editing index
      } else {
        // Add new visitor
        visitors.add(newVisitor);
      }
    });
  
    // Save the last used ID
    saveLastId(lastId);
      
    // Clear the text fields after adding or updating
    nameController.clear();
    emailController.clear();
    mobileController.clear();
    messageController.clear();

      // Save to Google Sheets
      saveToGoogleSheets(newVisitor);
    }     
  }

  void editVisitor(int index) {
    // Populate fields with existing visitor data
    nameController.text = visitors[index].name;
    emailController.text = visitors[index].email;
    mobileController.text = visitors[index].mobile;
    messageController.text = visitors[index].message;

    setState(() {
      editingIndex = index; // Set the editing index
    });
  }

  Future<void> saveToGoogleSheets(Visitor visitor) async {
    String jsonString = await rootBundle.loadString('assets/credentials.json');
    var jsonCredentials = json.decode(jsonString);
    var client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(jsonCredentials),
      [sheets.SheetsApi.spreadsheetsScope],
    );

    var sheetsApi = sheets.SheetsApi(client);
    var spreadsheetId = '1ckgOMQ0IaJawRCPgp3aswt_KS7nGkO1f2kWyHiGctDk';
    var range = 'Sheet3!A:F';

    //String formattedDateTime = formatDateTime();

    var rowData = sheets.ValueRange.fromJson({
      'values': [
        [
        visitor.id, // Use the visitor's ID for auto-numbering
        visitor.name,
        visitor.email,
        visitor.mobile,
        visitor.message,
        visitor.date, // For date
        DateFormat('yyyy-MM-dd hh:mm:ss a').format(visitor.datetime), // For datetime
      ],
      ],
    });

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
      appBar: AppBar(title: Text('Maklumat Pelawat'),
      automaticallyImplyLeading: false, // This will hide the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Attach the key to the form
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Enter Visitor Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Enter Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  if (!RegExp(pattern).hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: mobileController,
                decoration: InputDecoration(hintText: 'Enter Mobile Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  if (value.length < 10) {
                    return 'Please enter a valid mobile number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: messageController,
                decoration: InputDecoration(hintText: 'Enter Message'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: addVisitor,
                child: Text(editingIndex != null ? 'Update Visitor' : 'Add Visitor'),
              ),
              SizedBox(height: 10),
              visitors.isEmpty
                  ? Text('Tiada pelawat setakat hari ini.')
                  : Expanded(
                      child: ListView.builder(
                        itemCount: visitors.length,
                        itemBuilder: (context, index) => getRow(index),
                      ),
                    ),
          ],
        ),
      ),
      ),
    );
  }

  Widget getRow(int index) {
    return ListTile(
      title: Text('Maklumat Lanjut'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ID: ${visitors[index].id}'), 
          Text('Name: ${visitors[index].name}'),
          Text('Email: ${visitors[index].email}'),
          Text('Mobile: ${visitors[index].mobile}'),
          Text('Message: ${visitors[index].message}'),
          Text('Date: ${visitors[index].date}'), // Display date
          Text('Datetime: ${DateFormat('dd-MM-yyyy hh:mm:ss a').format(visitors[index].datetime)}'), // Display datetime
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              editVisitor(index);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                visitors.removeAt(index);
              });
            },
          ),
        ],
      ),
    );
  }
}
