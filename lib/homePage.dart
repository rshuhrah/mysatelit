import 'package:flutter/material.dart';
import 'package:mysatelit/displayforms.dart';
import 'package:mysatelit/drawer.dart';
import 'package:mysatelit/pertanyaan.dart';
//import 'package:mysatelit/queue.dart';
import 'package:mysatelit/visitor_comment.dart';
import 'package:mysatelit/calendar.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pejabat Satelit',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<GridListItem> gridItems = [
    GridListItem(
      title: 'BEZA SIMBOL TM dan R',
      url: 'https://www.facebook.com/MyIPOUTREACH/videos/ramai-yang-keliru-mengenai-penggunaan-simbol-tm-dan-simbol-rjom-kita-lihat-video/810101852902329/',
      icon: Icons.description,
      color: Colors.red,
    ),
    GridListItem(
      title: 'IP ONLINE SEARCH',
      url: 'https://iponlineext.myipo.gov.my/SPHI/Extra/IP/TM/Qbe.aspx?sid=638681201082673856',
      icon: Icons.branding_watermark,
      color: Color.fromARGB(255, 9, 12, 192),
    ),
    GridListItem(
      title: 'KELAS TM',
      url: 'https://www.myipo.gov.my/ms/pengkelasan-barangan-dan-perkhidmatan/',
      icon: Icons.book,
      color: Colors.blueGrey,
    ),
  ];

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showErrorMessage(context, 'Could not launch $url');
    }
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat Datang ke Pejabat Satelit - Terengganu'),
        titleTextStyle: TextStyle(color: Color.fromARGB(255, 14, 71, 117)),
      ),
      drawer: AppDrawer(),
      body: _buildBody(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.home, color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
                  Text('HOME', style: TextStyle(color: _selectedIndex == 0 ? Colors.blue : Colors.grey)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.comment, color: _selectedIndex == 1 ? Colors.red : Colors.grey),
                  Text('KOMEN', style: TextStyle(color: _selectedIndex == 1 ? Colors.red : Colors.grey)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person_add, color: _selectedIndex == 2 ? Colors.green : Colors.grey),
                  Text('PELAWAT', style: TextStyle(color: _selectedIndex == 2 ? Colors.green : Colors.grey)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.book, color: _selectedIndex == 3 ? Colors.orange : Colors.grey),
                  Text('BORANG PERMOHONAN BARU', style: TextStyle(color: _selectedIndex == 3 ? Colors.orange : Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildGridView(); // Home view with grid
      case 1:
        return VisitorComment(); // Page visitor to comment
      case 2:
        return Pertanyaan(); // User entry page
      case 3:
        return AppForm(); // Form new app page
      default:
        return _buildGridView();
    }
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: (3 / 2),
      ),
      itemCount: gridItems.length + 1,
      itemBuilder: (context, index) {
        if (index < gridItems.length) {
          return GestureDetector(
            onTap: () {
              _launchURL(gridItems[index].url);
            },
            child: Card(
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    gridItems[index].icon,
                    color: gridItems[index].color,
                    size: 40,
                  ),
                  SizedBox(height: 10),
                  Text(
                    gridItems[index].title,
                    style: TextStyle(fontSize: 14.0, color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        } else {
          return ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                //MaterialPageRoute(builder: (context) => VisitorQueueScreen()),
                MaterialPageRoute(builder: (context) => AppointmentScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.0),
              ),
              backgroundColor: Colors.amber,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.question_answer, color: Colors.blue),
                SizedBox(width: 8),
                //Text('Tekan untuk Pertanyaan'),
                Text('SET TEMUJANJI'),
              ],
            ),
          );
        }
      },
    );
  }
}

class GridListItem {
  final String title;
  final String url;
  final IconData icon;
  final Color color;

  GridListItem({required this.title, required this.url, required this.icon, required this.color});
}