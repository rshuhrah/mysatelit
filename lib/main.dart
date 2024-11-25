import 'package:flutter/material.dart';
//import 'package:mysatelit/about.dart';
//import 'package:mysatelit/datagrid.dart';
//import 'package:mysatelit/homePage.dart';
//import 'package:mysatelit/pertanyaan.dart';
//import 'package:mysatelit/temujanji.dart';
import 'mainPage.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pejabat Satelit',
      //initialRoute: '/homepage',
      //routes: {
        //'/homepage': (context) => HomePage(),
        //'/sheets': (context) => SheetData(),
        //'/visitorform': (context) => Pertanyaan(),
        //'/appointments': (context) => TemuJanji(title: 'Pelawat'),
        //'/about us': (context) => AboutPage(),
      //},
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
          fontFamily: 'Montserrat'
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }

}
