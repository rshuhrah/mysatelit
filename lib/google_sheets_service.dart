import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleSheetsService {
  final String sheetId;
  final String apiKey;

  GoogleSheetsService(this.sheetId, this.apiKey);

  // Fetch data from a specific column of any sheet (e.g., Sheet1, Sheet4)
  Future<List<String>> fetchColumn(String sheetName, String range) async {
    final url = 'https://sheets.googleapis.com/v4/spreadsheets/1ckgOMQ0IaJawRCPgp3aswt_KS7nGkO1f2kWyHiGctDk/values/Sheet1!A:D?key=AIzaSyADGMQFReLHPnPE8yExSNEJM6ADDMOhSy4';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<String> columnValues = [];

      if (data['values'] != null) {
        for (var row in data['values']) {
          columnValues.add(row[0]); // Assuming each row has a value in the first column
        }
      }
      return columnValues;
    } else {
      throw Exception('Failed to load data from $sheetName, status code: ${response.statusCode}');
    }
  }

  // Append a row of data to any sheet (e.g., Sheet1, Sheet4)
  Future<void> appendRow(
    String sheetName, String range, String name, String email, String mobile, String feedback, String dateTime) async {
  final url = 'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/Sheet4!A:E:append?valueInputOption=RAW&key=$apiKey';
  final data = {
    "values": [
      [name, email, mobile, feedback, dateTime],
    ]
  };

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to append data to $sheetName, status code: ${response.statusCode}');
  }
}


  // To fetch all rows from any sheet (e.g., Sheet1, Sheet4), not limited to a column
  Future<List<List<String>>> fetchRows(String sheetName, String range) async {
  final url = 'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/$sheetName!$range?key=$apiKey';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    List<List<String>> rows = [];

    if (data['values'] != null) {
      for (var row in data['values']) {
        rows.add(List<String>.from(row));
      }
    }
    return rows;
  } else {
    throw Exception('Failed to load rows from $sheetName, status code: ${response.statusCode}');
  }
}

}
