import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/backend/firebase/userDataProvider.dart';
import 'package:tim_app/model/BusinessModel.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/pages/admin/manage_business/operating_hours.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/business_links.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/thumbnail.dart';
import 'package:tim_app/pages/travellers/travel_history/components/trip_history.dart';
import 'package:tim_app/pages/travellers/travel_history/components/trip_history_rate.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/loading.dart';
import 'package:tim_app/utils/styles.dart';

class BusinessOfferTable extends StatefulWidget {
  const BusinessOfferTable({super.key});

  @override
  _BusinessOfferTableDemoState createState() => _BusinessOfferTableDemoState();
}

class _BusinessOfferTableDemoState extends State<BusinessOfferTable> {
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
      stream: fetchSpecialOffer(business?.businessID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        } else if (snapshot.hasData) {
          List<Map<String, dynamic>> data = snapshot.data!;
          return Theme(
            data: Theme.of(context).copyWith(
                cardColor: Colors.white60.withOpacity(0.10),
                dividerColor: Colors.blue,
                textTheme:
                    TextTheme(bodySmall: TextStyle(color: Colors.white))),
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
        item['offerCode'],
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
        title: const Text('Offer Preview'),
        actions: [],
        content: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
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
                                  item['offerCode'],
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

void evaluateResult(String result, BuildContext context) {
  Navigator.pop(context);
  Navigator.pop(context);
  if (result != 'success') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
  }
}
