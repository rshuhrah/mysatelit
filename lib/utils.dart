import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:async';

String deploymentID =
    "AKfycbxnkRRhgQ1S4d_0oz1HaRyLoyeH1G_bFx6au6WIm4WA8dSpH0lApWcQ5UhRe-Wh7M9TgwP";
String sheetID = "https://docs.google.com/spreadsheets/d/1ckgOMQ0IaJawRCPgp3aswt_KS7nGkO1f2kWyHiGctDk/edit?gid=0#gid=0"; // can be extracted from your google sheets url.

Future<Map> triggerWebAPP({required Map body}) async {
  Map dataDict = {};
  // ignore: non_constant_identifier_names
  Uri URL =
      Uri.parse("https://script.google.com/macros/s/AKfycbxnkRRhgQ1S4d_0oz1HaRyLoyeH1G_bFx6au6WIm4WA8dSpH0lApWcQ5UhRe-Wh7M9Tgw/exec");
  try {
    await http.post(URL, body: body).then((response) async {
      if ([200, 201].contains(response.statusCode)) {
        dataDict = jsonDecode(response.body);
      }
      if (response.statusCode == 302) {
        String redirectedUrl = response.headers['location'] ?? "";
        if (redirectedUrl.isNotEmpty) {
          Uri url = Uri.parse(redirectedUrl);
          await http.get(url).then((response) {

            if ([200, 201].contains(response.statusCode)) {

              dataDict = jsonDecode(response.body);
            }
          });
        }
      } else {
        print("Other StatusCOde: ${response.statusCode}");
      }
    });
  } catch (e) {
    print("FAILED: $e");
  }

  return dataDict;
}

Future<Map> getSheetsData({required String action}) async {
  Map body = {"sheetID": sheetID, "action": action};

  Map dataDict = await triggerWebAPP(body: body);

  return dataDict;
}