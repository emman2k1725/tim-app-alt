import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';

class ExcelUpload extends StatelessWidget {
  const ExcelUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ElevatedButton(
  onPressed: () async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'], // Allow only Excel file types
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      // Process the selected file (e.g., read Excel data)
      await processExcelFile(file);
    }
  },
  child: const Text('Pick Excel File'),
)
,
      ),
    );
  }
}

Future<void> processExcelFile(PlatformFile file) async {
  List<int> bytes;

  if (kIsWeb) {
    bytes = file.bytes!;
  } else {
    bytes = File(file.path!).readAsBytesSync();
  }

  final excel = Excel.decodeBytes(Uint8List.fromList(bytes));

  for (var table in excel.tables.keys) {
    print(table); // sheet Name
    print(excel.tables[table]?.maxCols);
    print(excel.tables[table]?.maxRows);

    var sheet = excel.tables[table]!;

    for (var row in sheet.rows) {
      // Iterate through cells in the row
      for (var cell in row) {
        print(cell!.value);
      }
    }
  }
}



