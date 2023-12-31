import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import 'manage_news_update.dart';

class ManageNewsTable extends StatefulWidget {
  const ManageNewsTable({super.key});

  @override
  _ManageNewsTableState createState() => _ManageNewsTableState();
}

class _ManageNewsTableState extends State<ManageNewsTable> {
  late int rowsPerPage = 10;
  List<DataRow> dataRows = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth >= 600 ? 100.0 : 10.0;
    final horizontalMargin = screenWidth > 600 ? 10.0 : 5.0;

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: fetchTableContentNews('News'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching data'));
        } else if (snapshot.hasData) {
          final data = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                  cardColor: Colors.white60.withOpacity(0.10),
                  dividerColor: Colors.blue,
                  textTheme:
                      TextTheme(bodySmall: TextStyle(color: Colors.white))),
              child: PaginatedDataTable(
                header: Text(
                  'List of Newsletter',
                  style: TextStyle(color: Colors.white),
                ),
                arrowHeadColor: Colors.blue,
                controller: ScrollController(),
                primary: false,
                columnSpacing: columnSpacing,
                horizontalMargin: horizontalMargin,
                columns: [
                  DataColumn(
                    label: Row(
                      children: [
                        Text(
                          'NEWS TITLE',
                          style: tableHeaderStyle,
                        ),
                      ],
                    ),
                    tooltip: 'News Title',
                  ),
                  DataColumn(
                    label: Row(
                      children: [
                        Text(
                          'DATE POSTED',
                          style: tableHeaderStyle,
                        ),
                      ],
                    ),
                    tooltip: 'Date posted',
                  ),
                  DataColumn(
                    label: Row(
                      children: [
                        Text(
                          'LINK',
                          style: tableHeaderStyle,
                        ),
                      ],
                    ),
                    tooltip: 'Website Link',
                  ),
                  DataColumn(
                    label: Row(
                      children: [
                        Text(
                          'Preview',
                          style: tableHeaderStyle,
                        ),
                      ],
                    ),
                    tooltip: 'Preview News',
                  ),
                  DataColumn(
                    label: Text(
                      'ACTION',
                      style: tableHeaderStyle,
                    ),
                    tooltip: '',
                  ),
                ],
                source: _MyDataTableSource(data!, context),
              ),
            ),
          );
        } else {
          return Center(child: Text('No data found'));
        }
      },
    );
  }
}

class _MyDataTableSource extends DataTableSource {
  _MyDataTableSource(this.data, this.context);

  final List<Map<String, dynamic>> data;
  final BuildContext context;

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    final item = data[index];
    return DataRow(cells: [
      DataCell(Text(
        item['contentTitle'].toString(),
        overflow: TextOverflow.visible,
        softWrap: true,
        style: tableContentStyle,
      )),
      DataCell(
        Container(
          constraints: BoxConstraints(
              maxWidth: 150), // Adjust the maximum width as needed
          child: Text(
            item['description'].toString(),
            overflow: TextOverflow
                .ellipsis, // Show ellipsis (...) when text overflows
            maxLines: 2, // Limit text to two lines, adjust as needed
            style: tableContentStyle,
          ),
        ),
      ),
      DataCell(
        Link(
          target: LinkTarget.blank,
          uri: Uri.parse('https://pub.dev/packages/url_launcher'),
          builder: (context, followLink) => IconButton(
              color: Colors.black54,
              icon: const Icon(
                Icons.link_rounded,
                color: Colors.white,
              ),
              onPressed: () async {
                Uri url = Uri.parse(item['website'].toString());
                var urllaunchable = await canLaunchUrl(
                    url); //canLaunch is from url_launcher package
                if (urllaunchable) {
                  await launchUrl(
                      url); //launch is from url_launcher package to launch URL
                } else {
                  print("URL can't be launched.");
                }
              }),
        ),
      ),
      DataCell(
        Link(
          target: LinkTarget.blank,
          uri: Uri.parse('https://pub.dev/packages/url_launcher'),
          builder: (context, followLink) => IconButton(
              color: Colors.white,
              icon: const Icon(Icons.visibility),
              onPressed: () async {
                _showRowDialog(item, context);
              }),
        ),
      ),
      DataCell(
        Row(
          children: [
            IconButton(
                color: Colors.white,
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => UpdateNewsDialog(newsData: item),
                  );
                }),
          ],
        ),
      ),
    ]);
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

void _showRowDialog(Map<String, dynamic> item, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final DateTime dateTime = item['createdAt'].toDate();
      final formattedDate =
          DateFormat('MMMM d, yyyy HH:mm:ss').format(dateTime);

      return AlertDialog(
        title: const Text('News Preview'),
        actions: [],
        content: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  // height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                                width: 1.0,
                              ),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: Image.network(item['displayImage'] ??
                                        'assets/images/empty-placeholder.png')
                                    .image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['contentTitle'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  item['description'],
                                  overflow: TextOverflow.visible,
                                  softWrap: true,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
