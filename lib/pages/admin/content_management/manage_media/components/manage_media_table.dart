import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class ManageMediaTable extends StatefulWidget {
  const ManageMediaTable({super.key});

  @override
  _ManageMediaTableState createState() => _ManageMediaTableState();
}

class _ManageMediaTableState extends State<ManageMediaTable> {
  late int rowsPerPage = 10;
  List<DataRow> dataRows = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth >= 600 ? 100.0 : 10.0;
    final horizontalMargin = screenWidth > 600 ? 10.0 : 5.0;

    return StreamBuilder<QuerySnapshot>(
      stream: fetchTableContent('Media'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        } else if (snapshot.hasData) {
          final List<Map<String, dynamic>> data =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            return document.data() as Map<String, dynamic>;
          }).toList();

          return Column(
            children: [
              if (data.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'No data available.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              if (data.isNotEmpty)
                PaginatedDataTable(
                  header: const Text('List of Media'),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        // Add your refresh logic here
                      },
                    ),
                  ],
                  arrowHeadColor: Colors.blue,
                  controller: ScrollController(),
                  primary: false,
                  columnSpacing: columnSpacing,
                  horizontalMargin: horizontalMargin,
                  columns: [
                    const DataColumn(
                      label: Expanded(
                        child: Center(
                          child: Text(
                            'MEDIA TITLE',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      tooltip: 'MEDIA Title',
                    ),
                    const DataColumn(
                      label: Expanded(
                        child: Center(
                          child: Text(
                            'DATE',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      tooltip: 'DATE',
                    ),
                    const DataColumn(
                      label: Expanded(
                        child: Center(
                          child: Text(
                            'LINK',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      tooltip: 'LINK',
                    ),
                    const DataColumn(
                      label: Expanded(
                        child: Center(
                          child: Text(
                            'PREVIEW',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      tooltip: 'PREVIEW',
                    ),
                    const DataColumn(
                      label: Expanded(
                        child: Center(
                          child: Text(
                            'ACTION',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      tooltip: 'ACTION',
                    ),
                  ],
                  source: _MyDataTableSource(data, context),
                ),
            ],
          );
        } else {
          return const Center(child: Text('No data found'));
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
      )),
      DataCell(
        Container(
          constraints: const BoxConstraints(maxWidth: 150),
          child: Text(
            item['description'].toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
                // Customize text style further if needed
                ),
          ),
        ),
      ),
      DataCell(
        Link(
          target: LinkTarget.blank,
          uri: Uri.parse('https://pub.dev/packages/url_launcher'),
          builder: (context, followLink) => IconButton(
              color: Colors.black54,
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
              color: Colors.black54,
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
              color: Colors.grey,
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
        title: const Text('Media Preview'),
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
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  item['description'],
                                  overflow: TextOverflow.visible,
                                  softWrap: true,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
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
