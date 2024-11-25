import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'google_sheets_service.dart'; // Ensure this path is correct for your service class
import 'package:table_calendar/table_calendar.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;

  final googleSheetsService = GoogleSheetsService(
    '1ckgOMQ0IaJawRCPgp3aswt_KS7nGkO1f2kWyHiGctDk', // Your spreadsheet ID
    'AIzaSyADGMQFReLHPnPE8yExSNEJM6ADDMOhSy4', // Your API key
  );

  // Controllers for the input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  // Function to show the TimePicker
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Function to combine the date and time into DateTime
  DateTime? getSelectedDateTime() {
    if (_selectedTime != null) {
      return DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Calendar widget for selecting a date
              TableCalendar(
                focusedDay: _selectedDate,
                firstDay: DateTime(2000),
                lastDay: DateTime(2100),
                selectedDayPredicate: (day) {
                  return isSameDay(day, _selectedDate);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                  });
                },
              ),
              SizedBox(height: 20),

              // Name input field
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),

              // Email input field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),

              // Mobile input field
              TextField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),

              // Time Picker Button
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text(
                  _selectedTime == null
                      ? 'Select Time'
                      : 'Selected Time: ${_selectedTime!.format(context)}',
                ),
              ),
              SizedBox(height: 20),

              // Display appointment details and confirm
              if (_selectedTime != null)
                Column(
                  children: [
                    Text(
                      'Appointment Details:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Date: ${_selectedDate.toLocal()}'.split(' ')[0],
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Time: ${_selectedTime!.format(context)}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        DateTime? selectedDateTime = getSelectedDateTime();
                        if (selectedDateTime != null) {
                          // Save to Google Sheets (appointment sheet in Sheet4)
                          _saveToGoogleSheets(selectedDateTime);
                        }
                      },
                      child: Text('Confirm Appointment'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to save the appointment to Google Sheets
  void _saveToGoogleSheets(DateTime dateTime) async {
  String name = _nameController.text;
  String email = _emailController.text;
  String mobile = _mobileController.text;
  String feedback = 'General Appointment'; // Or whatever the feedback message is

  // Validate input
  if (name.isEmpty || email.isEmpty || mobile.isEmpty) {
    _showErrorDialog('All fields are required.');
    return;
  }

  try {
    // Append the new appointment details to Google Sheets
    await googleSheetsService.appendRow(
      'Sheet4',  // The name of the sheet
      'A:E',     // The range
      name,      // Visitor's name
      email,     // Visitor's email
      mobile,    // Visitor's mobile number
      feedback,  // Visitor's feedback (e.g., 'General Appointment')
      DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime),  // Format the datetime
    );

    // Success dialog
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Appointment Confirmed'),
        content: Text('Your appointment is set for: $dateTime'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  } catch (e) {
    print('Error occurred: $e'); // Log the error
    _showErrorDialog('Failed to save appointment. Please try again.');
  }
}


  // Function to show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
