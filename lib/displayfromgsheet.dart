import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:intl/intl.dart';
import 'package:mysatelit/drawer.dart';

Future<List<List<dynamic>>> fetchSheetData(String spreadsheetId, String range) async {
  final jsonString = await rootBundle.loadString('assets/credentials.json');

  final client = await clientViaServiceAccount(
    ServiceAccountCredentials.fromJson(jsonString),
    [sheets.SheetsApi.spreadsheetsReadonlyScope],
  );

  final sheetsApi = sheets.SheetsApi(client);

  final response = await sheetsApi.spreadsheets.values.get(spreadsheetId, range);
  client.close();

  return response.values ?? [];
}

class MyHomePage extends StatelessWidget {
  final String spreadsheetId = '1ckgOMQ0IaJawRCPgp3aswt_KS7nGkO1f2kWyHiGctDk'; // Replace with your spreadsheet ID
  final String range = 'Sheet3!A:F';

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now()); // Format for comparison
    String displayDate = DateFormat('d MMMM yyyy EEEE').format(DateTime.now()); // Format for display

    return Scaffold(
      appBar: AppBar(
        title: Text('Senarai pelawat pada $displayDate'),
        //automaticallyImplyLeading: false, // This will hide the back button // Display in dd/MM/yyyy
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<List<List<dynamic>>>(
        future: fetchSheetData(spreadsheetId, range),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tiada rekod ditemui.'));
          } else {
            final data = snapshot.data!;
            final headers = data.isNotEmpty ? data[0] : [];

            // Filter rows to only include today's date
            final List<List<dynamic>> filteredRows = data.skip(1).where((row) {
              if (row.isNotEmpty && row.last is String) {
                // Compare date with today's date in yyyy-MM-dd format
                return row.last == currentDate; // Check if the last column matches the current date
              }
              return false;
            }).toList();

            // Adjust column widths based on content or screen width
            final double screenWidth = MediaQuery.of(context).size.width;
            final List<double> columnWidths = [
              screenWidth * 0.03, // First column (e.g., ID) wider
              screenWidth * 0.10, // Second column (e.g., Name)
              screenWidth * 0.11,  // Third column (e.g., Email)
              screenWidth * 0.08, // Fourth column (e.g., Mobile)
              screenWidth * 0.10, // Fifth column (e.g., Message)
              screenWidth * 0.10   // Sixth column (e.g., Date)
            ];

            final rows = filteredRows.map((row) {
              return DataRow(
                cells: row.asMap().entries.map((entry) {
                  int index = entry.key;
                  dynamic cell = entry.value;
                  // Convert the date from the last column to dd/MM/yyyy for display
                  if (index == headers.length - 1 && cell is String) {
                    DateTime? date = DateTime.tryParse(cell); // Try parsing the date
                    if (date != null) {
                      cell = DateFormat('dd/MM/yyyy').format(date); // Format to dd/MM/yyyy
                    }
                  }
                  return DataCell(
                    SizedBox(
                      width: columnWidths[index], // Set width for each cell
                      child: Text(
                        cell.toString(),
                        style: TextStyle(fontSize: 14),
                        maxLines: 3, // Allow multiple lines
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }).toList(),
              );
            }).toList();

            return SingleChildScrollView(
              scrollDirection: Axis.vertical, // Enable vertical scrolling
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                child: Container(
                  decoration: BoxDecoration(
                    //border: Border.all(color: Colors.grey, width: 1), // Border around the table
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  child: DataTable(
                    columns: List.generate(headers.length, (index) {
                      return DataColumn(
                        label: SizedBox(
                          width: columnWidths[index], // Set individual width for each column header
                          child: Text(
                            headers[index].toString(),
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }),
                    rows: rows,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Senarai Pelawat',
    home: MyHomePage(),
  ));
}
