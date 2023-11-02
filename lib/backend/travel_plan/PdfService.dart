import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:tim_app/backend/travel_plan/travelPlanFunction.dart';

class PdfService {
  printPdf(Map<String, dynamic> iteneraryData) async {
    PdfDocument document = PdfDocument();
    PdfGrid grid = PdfGrid();

    grid.columns.add(count: iteneraryData['day'] * 2);

    PdfGridRow header = grid.headers.add(1)[0];
    header.cells[0].value = "City to visit: ${iteneraryData['city']}";
    header.cells[0].columnSpan = header.cells.count ~/ 2;

    int headerIndex = header.cells.count ~/ 2;

    header.cells[headerIndex].value =
        "Days in City: ${iteneraryData['day']} days";
    header.cells[headerIndex].columnSpan = header.cells.count ~/ 2;

    header.style = PdfGridCellStyle(
      font: PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
        style: PdfFontStyle.bold,
      ),
    );
    String fromDate = DateFormat.yMMMMd()
        .format(DateTime.parse(iteneraryData['dates'][0]))
        .toString();
    String endDate = DateFormat.yMMMMd()
        .format(DateTime.parse(
            iteneraryData['dates'][iteneraryData['dates'].length - 1]))
        .toString();
    PdfGridRow header1 = grid.headers.add(1)[1];
    header1.cells[0].value = "Trip Date: $fromDate to $endDate";
    header1.cells[0].columnSpan = header1.cells.count;

    header1.style = PdfGridCellStyle(
      font: PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
        style: PdfFontStyle.bold,
      ),
    );

    PdfGridRow header2 = grid.headers.add(1)[2];
    PdfGridRow header3 = grid.headers.add(1)[3];
    int days = header2.cells.count ~/ 2;
    for (int x = 0; x < days; x++) {
      int counter = x;
      header2.cells[counter + x].value = "Day ${x + 1}";
      header2.cells[counter + x].columnSpan = 2;
      header2.cells[counter + x].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle);

      header3.cells[counter + x].value = "Time";
      header3.cells[counter + x].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle);

      header3.cells[counter + x + 1].value = "Place to Visit";
      header3.cells[counter + x + 1].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle);
    }
    header2.style = PdfGridCellStyle(
      font: PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
        style: PdfFontStyle.bold,
      ),
    );
    header3.style = PdfGridCellStyle(
      font: PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
        style: PdfFontStyle.bold,
      ),
    );
    // Arrange Itenerary to Day and Time
    List<List<Map<String, dynamic>>> iteneraryFinal =
        createDynamicColumn2DArray(iteneraryData['day']);
    for (int i = 0; i < iteneraryFinal.length; i++) {
      iteneraryFinal[i] = getPlacesByDate(
          iteneraryData['itenerary'], iteneraryData['dates'][i]);
    }

    PdfGridHeaderCollection dataHeaders = grid.headers;
    late List<int> iteneraryLengths = [];
    // Find the max length itenerary and add headers(max)
    for (int index = 0; index < iteneraryFinal.length; index++) {
      iteneraryLengths.add(iteneraryFinal[index].length);
    }
    int iteneraryMaxLength = iteneraryLengths
        .reduce((value, element) => value > element ? value : element);
    dataHeaders.add(iteneraryMaxLength);
    for (int innerIndex = 0; innerIndex < iteneraryFinal.length; innerIndex++) {
      int dataHeaderIndex = 4, counter = innerIndex;
      for (int outerIndex = 0;
          outerIndex < iteneraryFinal[innerIndex].length;
          outerIndex++) {
        debugPrint(iteneraryFinal[innerIndex][outerIndex]['businessName']);
        dataHeaders[dataHeaderIndex].cells[counter + innerIndex].value =
            iteneraryFinal[innerIndex][outerIndex]['timeSchedule'];

        dataHeaders[dataHeaderIndex].cells[counter + innerIndex + 1].value =
            iteneraryFinal[innerIndex][outerIndex]['businessName']
                .trim()
                .replaceAll(RegExp(r'[^\w\s]'), '');

        dataHeaderIndex++;
      }
    }
    grid.style = PdfGridStyle(
        cellPadding: PdfPaddings(left: 10, right: 3, top: 4, bottom: 5),
        backgroundBrush: PdfBrushes.white,
        textBrush: PdfBrushes.black,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 12));

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
    List<int> bytes = await document.save();

    AnchorElement(
        href:
            "data:application/actet-stream;charset=utf-16le;base64, ${base64.encode(bytes)}")
      ..setAttribute("download", "example.pdf")
      ..click();

    document.dispose();
  }

  List<Map<String, dynamic>> getPlacesByDate(dynamic data, dynamic date) {
    List<Map<String, dynamic>> arrangedData = [];
    late Map<String, dynamic> hotel;
    for (int index = 0; index < data.length; index++) {
      if (data[index]['sector'] == 'Hotel') {
        hotel = data[index];
      } else {
        if (data[index]['dateSchedule'] == date) {
          arrangedData.add(data[index]);
        }
      }
    }
    arrangedData = sortIt(arrangedData);
    arrangedData.insert(0, hotel);
    return arrangedData;
  }

  List<Map<String, dynamic>> sortIt(List<Map<String, dynamic>> list) {
    list.sort((a, b) => a['timeSchedule'].compareTo(b['timeSchedule']));
    return list;
  }
}
