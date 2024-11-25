import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleSheetsService {
  final String sheetId;
  final String apiKey;

  GoogleSheetsService(this.sheetId, this.apiKey);

  Future<List<String>> fetchColumn(String columnLetter) async {
    //final url = 'https://sheets.googleapis.com/v4/spreadsheets/1ckgOMQ0IaJawRCPgp3aswt_KS7nGkO1f2kWyHiGctDk/values/Sheet1?key=AIzaSyDhJ5FzzArI13JgmvTscQD7di1YTjKID_Y';
    final response = await http.get(Uri.parse('https://sheets.googleapis.com/v4/spreadsheets/1ckgOMQ0IaJawRCPgp3aswt_KS7nGkO1f2kWyHiGctDk/values/Sheet1!A:Z?key=AIzaSyDhJ5FzzArI13JgmvTscQD7di1YTjKID_Y'));

    //final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<String> columnValues = ['name', 'email', 'mobile', 'feedback', 'datetimecolumn'];

      if (data['values'] != null) {
        for (var row in data['values']) {
          columnValues.add(row[0]);
          columnValues.add(row[1]);
          columnValues.add(row[2]);
          columnValues.add(row[3]); // Assuming one value per row in the column
        }
      }
      return columnValues;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
