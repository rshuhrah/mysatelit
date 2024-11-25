import 'package:flutter/material.dart';
import 'data/database_helper.dart'; // Adjust the import based on your structure

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  String? name, email, mobile, feedback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feedback Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value,
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => email = value,
                validator: (value) => value!.isEmpty ? 'Enter your email' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mobile'),
                onSaved: (value) => mobile = value,
                validator: (value) => value!.isEmpty ? 'Enter your mobile number' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Feedback'),
                onSaved: (value) => feedback = value,
                validator: (value) => value!.isEmpty ? 'Enter your feedback' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _submitFeedback();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitFeedback() async {
    final feedbackData = {
      'name': name,
      'email': email,
      'mobile': mobile,
      'feedback': feedback,
      'datetime': DateTime.now().toIso8601String(),
    };
    
    await DatabaseHelper().insertFeedback(feedbackData);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Feedback submitted!')));
    _formKey.currentState!.reset();
  }
}
