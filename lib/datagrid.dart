import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
//import 'google_sheets_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
//import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Senarai dari Google Sheets',
      home: SheetData(),
    );
  }
}

class SheetData extends StatefulWidget {
  const SheetData({super.key});

  @override
  _SheetDataState createState() => _SheetDataState();
}

class _SheetDataState extends State<SheetData> {
  final List<String> headers = ['Name', 'Email', 'Mobile', 'Feedback', 'Datetime'];
  List<List<String>> _data = [];
  
  String currentDateTime = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

  void addData(String name, String email, String mobile, String feedback, String currentDateTime) {
    // Get the current date and time
    DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

    // Add a new row with name, phone, and current DateTime
    _data.add([name, email, mobile, feedback, currentDateTime]); // Ensure elements

    // Optionally, print the data to verify
    print(_data);
  }


  @override
  void initState() {
    super.initState();
    fetchSheetData();
  }

  Future<void> fetchSheetData() async {
  try {
    final response = await http.get(Uri.parse('https://sheets.googleapis.com/v4/spreadsheets/1ckgOMQ0IaJawRCPgp3aswt_KS7nGkO1f2kWyHiGctDk/values/Sheet3!A1:Z?key=AIzaSyDhJ5FzzArI13JgmvTscQD7di1YTjKID_Y'));

    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<List<String>> allData = (jsonData['values'] as List<dynamic>)
        .map((row) => (row as List<dynamic>).map((item) => item.toString()).toList())
        .toList()
        .cast<List<String>>();

      // Filter data based on the date in the 5th column
      _data = allData.where((row) {
        if (row.length < 5) return false; // Ensure there's enough data
        String dateString = row[4]; // Assuming the date is in the 5th column
        // Check if dateString starts with today's date
        return dateString.startsWith(today);
      }).toList();

      // Call setState after updating _data
      setState(() {});
    } else {
      // Handle response error
      print('Error: ${response.statusCode}');
      setState(() {
        // Optionally handle state
      });
    }
  } catch (e) {
    print("Error fetching data: $e");
    setState(() {
      // Optionally handle error state
    });
  }
}



 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('\nSenarai Pelawat Pejabat Satelit - Terengganu\n', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),)),
    body: SingleChildScrollView(
      child: Column(
        children: [
          // Wrap the DataTable in a SizedBox to control width
          SizedBox(
            width: MediaQuery.of(context).size.width, // Make it fit the screen width
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Allow horizontal scrolling
              child: DataTable(
              columns: headers.map((header) => DataColumn(label: Expanded(child: Text(header, overflow: TextOverflow.ellipsis)))).toList(),
              rows: List<DataRow>.generate(_data.length, (index) {
                return DataRow(
                  color: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                    return index.isEven ? Colors.grey[200] : Colors.white;
                  }),
                  cells: [
                    for (int i = 0; i < headers.length; i++)
                      DataCell(
                        SizedBox(
                          child: Text(
                            _data[index][i],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                  ],
                );
              }),
              border: TableBorder.all(),
            ),
            ),
          ),
          if (_data.isEmpty) // Show message when there's no data
            Center(child: Text('Tiada pelawat pada hari ini')),
        ],
      ),
    ),
  );
}
}