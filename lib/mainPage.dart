import 'package:flutter/material.dart';
import 'package:mysatelit/displayforms.dart';
//import 'bottom_navigation_bar.dart'; // Import your new BottomNavigationBar file
import 'package:mysatelit/displayfromgsheet.dart';
import 'package:mysatelit/pertanyaan.dart';
//import 'temujanji.dart';
import 'homePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends State<MainPage> {
  final list = [HomePage(), MyHomePage(), Pertanyaan(), AppForm()];
  int _selectedIndex = 0;

  void onTap(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/appbar2.png',
          height: 6000,
          width: 6000,
          fit: BoxFit.scaleDown,
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFF01579B),
      body: list[_selectedIndex],
      //bottomNavigationBar: BottomNavigationBarExample(
        //selectedIndex: _selectedIndex,
        //onTap: onTap,
      //),
    );
  }
}
