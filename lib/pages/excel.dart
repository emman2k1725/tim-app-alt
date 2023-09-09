import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:tim_app/backend/firebase/applyBusiness.dart';
import 'package:tim_app/model/BusinessModel.dart';

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
        ),
      ),
    );
  }
}

Future<void> processExcelFile(PlatformFile file) async {
  List<int> bytes;
  BusinessModel? businessData = BusinessModel.withDefaultValues();
  try {
    if (kIsWeb) {
      bytes = file.bytes!;
    } else {
      bytes = File(file.path!).readAsBytesSync();
    }

    final excel = Excel.decodeBytes(Uint8List.fromList(bytes));

    for (var table in excel.tables.keys) {
      var sheet = excel.tables[table]!;
      for (var row in sheet.rows) {
        List<dynamic> rowData = [];
        for (var cell in row) {
          rowData.add(cell!.value.toString());
        }
        businessData.status = 'Dummy';
        businessData.businessName = rowData[0];
        //Address
        businessData.businessAddress!['building'] = rowData[1];
        businessData.businessAddress!['street'] = rowData[2];
        businessData.businessAddress!['city'] = rowData[3];
        businessData.businessAddress!['postal'] = rowData[4];
        businessData.businessAddress!['country'] = rowData[5];
        // Phone Number
        businessData.businessPhoneNumber!['countryCode'] =
            rowData[6].substring(0, 3);
        businessData.businessPhoneNumber!['number'] =
            rowData[6].toString().replaceAll(' ', '');
        businessData.cruisine = rowData[7];
        businessData.businessDesc = rowData[8].toString();
        businessData.businessLinks!['googleMap'] = rowData[9];
        businessData.businessSector = rowData[10];
        //Business Hours
        businessData.businessHours!['Monday']![0] = rowData[11];
        businessData.businessHours!['Monday']![1] = rowData[12];
        businessData.businessHours!['Tuesday']![0] = rowData[11];
        businessData.businessHours!['Tuesday']![1] = rowData[12];
        businessData.businessHours!['Wednesday']![0] = rowData[11];
        businessData.businessHours!['Wednesday']![1] = rowData[12];
        businessData.businessHours!['Thursday']![0] = rowData[11];
        businessData.businessHours!['Thursday']![1] = rowData[12];
        businessData.businessHours!['Friday']![0] = rowData[11];
        businessData.businessHours!['Friday']![1] = rowData[12];
        businessData.businessHours!['Saturday']![0] = rowData[11];
        businessData.businessHours!['Saturday']![1] = rowData[12];
        businessData.businessHours!['Sunday']![0] = rowData[11];
        businessData.businessHours!['Sunday']![1] = rowData[12];
        // Insert to Firebase
        await applyBusiness(businessData).then((value) {
          debugPrint(value);
        });
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}
