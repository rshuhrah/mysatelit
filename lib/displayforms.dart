import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Home Screen'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppForm()),
                );
              },
              child: Text('Open Form Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class AppForm extends StatelessWidget {
  const AppForm({super.key});

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Borang bagi permohonan baru'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            title: Text('Hak Cipta'),
            onTap: () {
              // Open PDF inside app
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFViewerPage(
                    url: 'https://www.myipo.gov.my/wp-content/uploads/2024/07/myipo-form-cr1-2024-en.pdf',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Petunjuk Geografi'),
            onTap: () {
              _launchURL('https://drive.google.com/file/d/1hAmIyMsG8MFFx3CIK3RWATbotX0UeUJH/view?pli=1');
            },
          ),
          ListTile(
            title: Text('Paten'),
            onTap: () {
              _launchURL('https://www.myipo.gov.my/wp-content/uploads/2022/12/1.Patents-Form-No.1.pdf');
            },
          ),
          ListTile(
            title: Text('Cap Dagangan'),
            onTap: () {
              _launchURL('https://drive.google.com/file/d/1E_BX5G0B05JljLDnWu1jr1M0EqvXOhG3/view');
            },
          ),
        ],
      ),
    );
  }
}

class PDFViewerPage extends StatelessWidget {
  final String url;
  const PDFViewerPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Viewer')),
      body: PDFView(
        filePath: url, // Assuming the URL is a direct PDF link
      ),
    );
  }
}
