//import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'models/contact.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemuJanji extends StatefulWidget {
  const TemuJanji({super.key, required this.title});

  final String title;
  

  @override
  State<TemuJanji> createState() => _TemuJanjiState();
}

class _TemuJanjiState extends State<TemuJanji> {
  final _formKey = GlobalKey<FormState>();

  /// Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  List<Contact> contacts = List.empty(growable: true);

  bool isSubmitting = false;

  void _submitForm(DateTime dateTime) async {
  if (_formKey.currentState!.validate() && !isSubmitting) {
    setState(() {
      isSubmitting = true; // Disable further submissions
    });

    const String scriptURL =
        'https://script.google.com/macros/s/AKfycbxnkRRhgQ1S4d_0oz1HaRyLoyeH1G_bFx6au6WIm4WA8dSpH0lApWcQ5UhRe-Wh7M9Tgw/exec';

    String tempName = nameController.text;
    String tempEmail = emailController.text;
    String tempMobile = mobileController.text;
    String tempFeedback = feedbackController.text;

     // Create a new contact and add it to the contacts list
    contacts.add(Contact(
      name: tempName,
      email: tempEmail,
      mobile: tempMobile,
      feedback: tempFeedback,
      datetime: DateTime.now(), // Store the current DateTime
    ));

    // Save the contacts to SharedPreferences
    saveIntoSp();

    // Clear input fields
    nameController.clear();
    emailController.clear();
    mobileController.clear();
    feedbackController.clear();

    // Format the DateTime to ISO 8601
    String dateTimeColumn = dateTimeController.text; // Use the passed dateTime argument
    // Create the query string
    String queryString = "?name=${Uri.encodeComponent(tempName)}"
        "&email=${Uri.encodeComponent(tempEmail)}"
        "&mobile=${Uri.encodeComponent(tempMobile)}"
        "&feedback=${Uri.encodeComponent(tempFeedback)}"
        "&dateTimeColumn=${Uri.encodeComponent(dateTimeColumn)}";

    // Make the HTTP GET request
    try {
      final response = await http.get(Uri.parse(scriptURL + queryString));

      if (response.statusCode == 200) {
        print('Data submitted successfully: ${response.body}');
      } else {
        print('Error submitting data: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }

    setState(() {
      isSubmitting = false; // Re-enable submissions
    });
  }
}

  int selectedIndex = -1;

  late SharedPreferences sp;


  bool validateEmail(String value) {
    bool emailController = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return emailController;
  }

  getSharedPrefrences() async {
    sp = await SharedPreferences.getInstance();
    readFromSp();
  }

saveIntoSp() {
  List<String> contactListString = contacts.map((contact) => jsonEncode(contact.toJson())).toList();
  sp.setStringList('myData', contactListString);
}


readFromSp() {
  List<String>? contactListString = sp.getStringList('myData');
  contacts = contactListString!.map((contact) => Contact.fromJson(json.decode(contact))).toList();
  setState(() {}); // Update the UI
}

 void importJsonData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/contact.json');
    String contactListString = await file.readAsString();
    DateTime.now(); 
    jsonDecode(contactListString);
    setState(() {});   
 }
 
  @override
  void initState() {
    super.initState();
    getSharedPrefrences();
    displayDateTime();
    //dateTimeController.text = DateTime.now().toString();
  }
void displayDateTime() {
  DateTime now = DateTime.now();
  String formattedDateTime = DateFormat('dd-MM-yyyy – hh:mm:ss a').format(now);
  dateTimeController.text = formattedDateTime; // Set the formatted date and time
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value == "") {
                      return "Masukkan nama yang sah";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Masuk Nama Pelawat',
                  ),
                  controller: nameController,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == "") {
                      return "Alamat Emel";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  controller: emailController,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == "") {
                      return "Masukkan no mobil yang sah";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Mobile Nombor',
                  ),
                  controller: mobileController,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == "") {
                      return "Masukkan maklumbalas";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Feedback',
                  ),
                  controller: feedbackController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == "") {
                      return "Date Time";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Date Time',
                    //border: OutlineInputBorder(),
                  ),
                  controller: dateTimeController,
                  readOnly: true,
                ),
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      _submitForm(DateTime.now());
                      //
                      String name = nameController.text.trim();
                      String email = emailController.text.trim();
                      String mobile = mobileController.text.trim();
                      String feedback = feedbackController.text.trim();
                      DateTime.now().toIso8601String();
                      if (name.isNotEmpty && email.isNotEmpty && mobile.isNotEmpty && feedback.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          emailController.text = '';
                          mobileController.text = '';
                          feedbackController.text = '';
                          //dateTimeController.text = '';
                          contacts.add(Contact(name: name, email: email, mobile: mobile, feedback: feedback, datetime: DateTime.now() ));
                        });
                        // Saving contacts list into Shared Prefrences
                        saveIntoSp();
                      }
                      //
                    },
                    child: const Text('Save')),
                ElevatedButton(
                    onPressed: () async {
                      _submitForm(DateTime.now());
                      //
                      String name = nameController.text.trim();
                      String email = emailController.text.trim();
                      String mobile = mobileController.text.trim();
                      String feedback = feedbackController.text.trim();
                      //String dateTimeColumn
                      if (name.isNotEmpty && email.isNotEmpty && mobile.isNotEmpty && feedback.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          emailController.text = '';
                          mobileController.text = '';
                          feedbackController.text = '';
                          dateTimeController.text = '';
                          contacts[selectedIndex].name = name;
                          contacts[selectedIndex].email = email;
                          contacts[selectedIndex].mobile = mobile;
                          contacts[selectedIndex].feedback = feedback;
                          contacts[selectedIndex].datetime = DateTime.now();
                          selectedIndex = -1;
                        });
                        // Saving contacts list into Shared Prefrences
                       saveIntoSp();
                      }
                      //
                    },
                    child: const Text('Update')),
              ],
            ),
            const SizedBox(height: 10),
            contacts.isEmpty
                ? const Text(
                    'Tiada maklumat pelawat..',
                    style: TextStyle(fontSize: 22),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  )
          ],
        ),
      ),),),);
  }


 Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.blueGrey : Colors.blue,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              contacts[index].email,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].mobile),
            Text(contacts[index].feedback),
            Text(DateFormat('dd-MM-yyyy – hh:mm:ss a').format(contacts[index].datetime)),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    //
                    nameController.text = contacts[index].name;
                    emailController.text = contacts[index].email;
                    mobileController.text = contacts[index].mobile;
                    feedbackController.text = contacts[index].feedback;
                    dateTimeController.text = contacts[index].datetime as String;
                    setState(() {
                      selectedIndex = index;
                    });
                    //
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() async {
                    //
                    setState(() {
                      contacts.removeAt(index);
                    });
                    // Saving contacts list into Shared Prefrences
                     saveIntoSp();
                    //
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
