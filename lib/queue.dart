import 'package:flutter/material.dart';
import 'package:mysatelit/drawer.dart';

class VisitorQueueScreen extends StatelessWidget {
  final int currentVisitorNumber = 1; // Placeholder for current number
  final int nextVisitorNumber = 2;

  const VisitorQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nombor Menunggu Pelawat'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 127, 127, 129),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Use Container with a fixed width
            SizedBox(
              width: double.infinity, // To make sure it takes up full available width
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Current Visitor Number',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '$currentVisitorNumber',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 72, 27, 155)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity, // Ensures same width as the previous Card
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Next Visitor Number',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          '$nextVisitorNumber',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 72, 27, 155)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class AdminQueueScreen extends StatefulWidget {
  const AdminQueueScreen({super.key});

  @override
  _AdminQueueScreenState createState() => _AdminQueueScreenState();
}

class _AdminQueueScreenState extends State<AdminQueueScreen> {
  List<int> queueNumbers = [];
  int nextNumber = 1;
  int? currentVisitorNumber;

  void addVisitorToQueue() {
    setState(() {
      queueNumbers.add(nextNumber);
      nextNumber++;
    });
  }

  void callNextVisitor() {
    if (queueNumbers.isNotEmpty) {
      setState(() {
        currentVisitorNumber = queueNumbers.removeAt(0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin to Manage Queue Number'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (currentVisitorNumber != null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Current Visitor Number: $currentVisitorNumber',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Next Visitor Number: $nextNumber',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: queueNumbers.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text('Visitor Queue Number: ${queueNumbers[index]}'),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: addVisitorToQueue,
                  icon: Icon(Icons.add),
                  label: Text('Add Visitor to Queue'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: callNextVisitor,
                  icon: Icon(Icons.call),
                  label: Text('Call Next Visitor'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
