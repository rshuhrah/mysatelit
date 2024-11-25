import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mysatelit/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
// Ensure you import your main navigation page

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black), // Default text style
                children: <TextSpan>[
                  TextSpan(text: '- Maklumat berkenaan pelawat Pejabat Satelit \n'),
                  TextSpan(text: '- Memasukkan maklumat pelawat baru \n'),
                  TextSpan(text: '- Dokumentasi - dalam proses ....\n'),
                  TextSpan(
                    text: '- Live data: \n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' https://docs.google.com/spreadsheets/d/1ckgOMQ0IaJawRCPgp3aswt_KS7nGkO1f2kWyHiGctDk/edit?gid=2038452491',
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final url = 'https://docs.google.com/spreadsheets/d/1ckgOMQ0IaJawRCPgp3aswt_KS7nGkO1f2kWyHiGctDk/edit?gid=2038452491';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
