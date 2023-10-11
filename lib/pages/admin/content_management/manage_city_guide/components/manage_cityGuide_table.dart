import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class ManageCityGuideTable extends StatefulWidget {
  const ManageCityGuideTable({super.key});

  @override
  _ManageCityGuideTableState createState() => _ManageCityGuideTableState();
}

class _ManageCityGuideTableState extends State<ManageCityGuideTable> {
  late int rowsPerPage = 10;
  List<DataRow> dataRows = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth >= 600 ? 100.0 : 10.0;
    final horizontalMargin = screenWidth > 600 ? 10.0 : 5.0;

    return StreamBuilder<QuerySnapshot>(
      stream: fetchTableContent('City Guide'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching data'));
        } else if (snapshot.hasData) {
          final List<Map<String, dynamic>> data =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            return document.data() as Map<String, dynamic>;
          }).toList();

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
                  'List of City Guide',
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
                          'MEDIA TITLE',
                          style: tableHeaderStyle,
                        ),
                      ],
                    ),
                    tooltip: 'MEDIA Title',
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
                          'PREVIEW',
                          style: tableHeaderStyle,
                        ),
                      ],
                    ),
                    tooltip: 'Preview MEDIA',
                  ),
                  DataColumn(
                    label: Text(
                      'ACTION',
                      style: tableHeaderStyle,
                    ),
                    tooltip: '',
                  ),
                ],
                source: _MyDataTableSource(data, context),
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
          constraints: BoxConstraints(maxWidth: 150),
          child: Text(
            item['description'].toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: tableContentStyle,
          ),
        ),
      ),
      DataCell(
        Link(
          target: LinkTarget.blank,
          uri: Uri.parse('https://pub.dev/packages/url_launcher'),
          builder: (context, followLink) => IconButton(
              color: Colors.white,
              icon: const Icon(Icons.link_rounded),
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
                // actionImage(index);
              },
            ),
            IconButton(
              color: Colors.green,
              icon: const Icon(Icons.archive_outlined),
              onPressed: () {
                // onActionIconSelected(index);
              },
            ),
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
