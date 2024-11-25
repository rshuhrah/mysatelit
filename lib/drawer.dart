// drawer.dart
import 'package:flutter/material.dart';
import 'package:mysatelit/about.dart';
import 'package:mysatelit/adminqueuescreen.dart';
//import 'package:mysatelit/displayforms.dart';
import 'package:mysatelit/displayfromgsheet.dart';
import 'package:mysatelit/homePage.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                fit:BoxFit.cover,
                image: NetworkImage('images/myipo logo.jpg'),
              ),
            ),
            child: Text(
              'Hi, User',
              style: TextStyle(
                color: const Color.fromARGB(255, 11, 58, 97),
                fontSize: 24,
              ),
            ),
          ),
          // Drawer Items
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              //Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()), // Navigate to Second Page
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.admin_panel_settings),
            title: Text('Admin'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminQueueScreen()), //go to admin queue page
               ); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.document_scanner),
            title: Text('Google Sheet'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()), //go to about page
              );
            },
          ),
          //ListTile(
            //leading: Icon(Icons.data_array),
            //title: Text('Forms'),
            //onTap: () {
              //Navigator.push(
                //context,
                //MaterialPageRoute(builder: (context) => AppForm()), //go to about page
              //);
            //},
          //),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()), //go to about page
              );
            },
          ),
        ],
      ),
    );
  }
}
