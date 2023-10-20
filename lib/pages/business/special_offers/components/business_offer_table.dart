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
      return AlertDialog(
        title: const Text('Business Details'),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              showCustomLoadingDialog(context, 'Loading...');
              String result =
                  await businessPendingAction(item['docID'], 'Approved');
              evaluateResult(result, context);
            },
            icon: const Icon(Icons.check),
            label: const Text('Approve'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.all(20)),
          ),
          const SizedBox(width: 8), // Add some space between the buttons
          ElevatedButton.icon(
            onPressed: () async {
              showCustomLoadingDialog(context, 'Loading...');
              String result =
                  await businessPendingAction(item['docID'], 'Declined');
              evaluateResult(result, context);
            },
            icon: const Icon(Icons.close),
            label: const Text('Decline'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, padding: const EdgeInsets.all(20)),
          ),
        ],
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width:
                            100, // Set the desired width for the circular avatar
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue, // Set the color of the border
                            width: 1.0, // Set the width of the border
                          ),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: Image.network(item['businessImages']
                                        ['logo'] ??
                                    'assets/images/empty-placeholder.png')
                                .image, // Replace 'your_image.png' with the actual image path
                            fit: BoxFit
                                .cover, // Choose the appropriate fit option for your design
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['businessName']
                              .toString(), // Replace with your name or text
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          item['businessEmail']
                              .toString(), // Replace with your name or text
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          item['businessDesc']
                              .toString(), // Replace with your name or text
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['businessSector']
                              .toString(), // Replace with your name or text
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          item['businessAddress']['country']
                              .toString(), // Replace with your name or text
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          item['businessPhoneNumber']['countryCode']
                                  .toString() +
                              item['businessPhoneNumber']['number']
                                  .toString(), // Replace with your name or text
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Business Thumbnail', // Replace with your name or text
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageRowPage(item: item),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                height: 330,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Business Address', // Replace with your name or text
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        SizedBox(
                          width: 500,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Country', // Replace with your name or text
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                item['businessAddress'][
                                    'country'], // Replace with your name or text
                                style: const TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'City', // Replace with your name or text
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                item['businessAddress']
                                    ['city'], // Replace with your name or text
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        SizedBox(
                          width: 500,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Postal Code', // Replace with your name or text
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                item['businessAddress'][
                                    'postal'], // Replace with your name or text
                                style: const TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Building Address', // Replace with your name or text
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                item['businessAddress'][
                                    'building'], // Replace with your name or text
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Business Links', // Replace with your name or text
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    BusinessLinks(item: item),
                    const SizedBox(height: 20.0),
                    Align(
                        alignment: Alignment.topLeft,
                        child: OperatingHours(
                          operatingHours: item['businessHours'],
                        )),
                  ],
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
