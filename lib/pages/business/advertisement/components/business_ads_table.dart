// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/model/BusinessModel.dart';
import 'package:tim_app/pages/travellers/travel_history/components/trip_history.dart';
import 'package:tim_app/utils/styles.dart';

import '../../../../utils/responsive.dart';
import '../../../../widgets/blurContainer.dart';

class BusinessAdsTable extends StatefulWidget {
  const BusinessAdsTable({super.key});

  @override
  _BusinessAdsTableState createState() => _BusinessAdsTableState();
}

class _BusinessAdsTableState extends State<BusinessAdsTable> {
  BusinessModel? business;
  @override
  void initState() {
    super.initState();
    loadNewLaunch();
  }

  loadNewLaunch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('business') != null) {
      setState(() {
        business = BusinessModel.fromMapWithID(
            jsonDecode(pref.getString('business')!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const int rowsPerPage = 10;

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: fetchAds(''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        } else if (snapshot.hasData) {
          List<Map<String, dynamic>> data = snapshot.data!;

          return Responsive.isDesktop(context)
              ? Theme(
                  data: Theme.of(context).copyWith(
                      cardColor: Colors.white60.withOpacity(0.10),
                      dividerColor: Colors.blue,
                      textTheme: const TextTheme(
                          bodySmall: TextStyle(color: Colors.white))),
                  child: PaginatedDataTable(
                    arrowHeadColor: Colors.white,
                    rowsPerPage: rowsPerPage,
                    columns: [
                      DataColumn(
                        label: Row(
                          children: [
                            Text(
                              'Title',
                              style: tableHeaderStyle,
                            ),
                          ],
                        ),
                        tooltip: 'Title',
                      ),
                      DataColumn(
                        label: Row(
                          children: [
                            Text(
                              'Offer Code',
                              style: tableHeaderStyle,
                            ),
                          ],
                        ),
                        tooltip: 'Offer Code',
                      ),
                      DataColumn(
                        label: Text(
                          'Date Created',
                          style: tableHeaderStyle,
                        ),
                        tooltip: 'Date Created',
                      ),
                      DataColumn(
                        label: Row(
                          children: [
                            Text(
                              'Status',
                              style: tableHeaderStyle,
                            ),
                          ],
                        ),
                        tooltip: 'Status',
                      ),

                      DataColumn(
                        label: Text(
                          'Action',
                          style: tableHeaderStyle,
                        ),
                        tooltip: '',
                      ),
                      // Add more columns as needed
                    ],
                    source: _MyDataTableSource(data, context),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: ((context, index) =>
                              const SizedBox(height: 15)),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            DateTime parsedDate =
                                DateTime.parse(data[index]['createAt']);
                            String formattedDate =
                                DateFormat('MMM dd, yyyy').format(parsedDate);
                            return BlurContainer(
                                childColumn: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Title',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            data[index]['title'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 30),
                                          Text(
                                            'Offer Code',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            data[index]['placement'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Date Created',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            formattedDate,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 30),
                                          Text(
                                            'Status',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            data[index]['status'].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Divider(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Action',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.visibility,
                                              color: Colors.green,
                                            ),
                                            onPressed: () {
                                              _showRowDialog(
                                                  data[index], context);
                                            },
                                          ),
                                          IconButton(
                                              icon: const Icon(
                                                Icons.archive,
                                                color: Colors.blue,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const TripHistoryTable()),
                                                );
                                              }),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ));
                          },
                        )
                      ],
                    ),
                  ),
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

    DateTime parsedDate = DateTime.parse(item['createAt']);
    String formattedDate = DateFormat('MMM dd, yyyy').format(parsedDate);

    return DataRow(cells: [
      DataCell(Text(
        item['title'],
        style: tableContentStyle,
      )),
      DataCell(Text(
        item['placement'],
        style: tableContentStyle,
      )),
      DataCell(Text(
        formattedDate,
        style: tableContentStyle,
      )),
      DataCell(Text(
        item['status'].toString(),
        style: tableContentStyle,
      )),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.visibility,
                color: Colors.green,
              ),
              onPressed: () {
                _showRowDialog(item, context);
              },
            ),
            IconButton(
                icon: const Icon(
                  Icons.archive,
                  color: Colors.blue,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TripHistoryTable()),
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
      DateTime parsedDate = DateTime.parse(item['createAt']);
      String formattedDate = DateFormat('MMM dd, yyyy').format(parsedDate);

      return AlertDialog(
        title: const Text('Ads Preview'),
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
                                image: Image.network(item['imageURL'] ??
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
                                  item['title'],
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
                                  item['placement'],
                                  overflow: TextOverflow.visible,
                                  softWrap: true,
                                  textAlign: TextAlign.justify,
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
