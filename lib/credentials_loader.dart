// lib/credentials_loader.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, dynamic>> loadCredentials() async {
  String jsonString = await rootBundle.loadString('assets/credentials.json');
  return json.decode(jsonString);
}
