import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/manage_business/operating_hours.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/business_links.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/thumbnail.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/utils/styles.dart';

import '../../../utils/loading.dart';

class TravellerAccountTable extends StatefulWidget {
  const TravellerAccountTable({super.key});

  @override
  State<TravellerAccountTable> createState() => _TravellerAccountTableState();
}

class _TravellerAccountTableState extends State<TravellerAccountTable> {
  @override
  @override
  Widget build(BuildContext context) {
    const int rowsPerPage = 10;

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: fetchTableAdminAccount(false),
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
              header: Text(
                'Traveller Account',
                style: TextStyle(color: Colors.lightBlueAccent),
              ),
              rowsPerPage: rowsPerPage,
              columns: [
                DataColumn(
                  label: Row(
                    children: [
                      Text(
                        'Traveller Name',
                        style: tableHeaderStyle,
                      ),
                    ],
                  ),
                  tooltip: 'Traveller Name',
                ),
                DataColumn(
                  label: Row(
                    children: [
                      Text(
                        'Traveller Email',
                        style: tableHeaderStyle,
                      ),
                    ],
                  ),
                  tooltip: 'Traveller Email',
                ),
                DataColumn(
                  label: Row(
                    children: [
                      Text(
                        'Phone Number',
                        style: tableHeaderStyle,
                      ),
                    ],
                  ),
                  tooltip: 'Phone Number',
                ),
                DataColumn(
                  label: Text(
                    'Country',
                    style: tableHeaderStyle,
                  ),
                  tooltip: 'Country',
                ),
                DataColumn(
                  label: Text(
                    'Action',
                    style: tableHeaderStyle,
                  ),
                  tooltip: 'Action',
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
    return DataRow(cells: [
      DataCell(Text(
        item['firstName'].toString(),
        style: tableContentStyle,
      )),
      DataCell(Text(
        item['email'].toString(),
        style: tableContentStyle,
      )),
      DataCell(Text(
        item['mobileNumber'].toString(),
        style: tableContentStyle,
      )),
      DataCell(Text(
        item['nationality'].toString(),
        style: tableContentStyle,
      )),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.no_accounts, color: Colors.white),
              onPressed: () {
                // Call the onActionIconSelected callback when the icon is clicked
                _showRowDialog(item, context);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.visibility,
                color: Colors.white,
              ),
              onPressed: () {},
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
      return AlertDialog(
        title: const Text('Traveller Account'),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              // showCustomLoadingDialog(context, 'Loading...');
              // String result =
              //     await businessPendingAction(item['docID'], 'Approved');
              // evaluateResult(result, context);
            },
            icon: Icon(Icons.arrow_back),
            label: Text('Go Back'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, padding: EdgeInsets.all(15)),
          ),
          SizedBox(width: 4), // Add some space between the buttons
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              // showCustomLoadingDialog(context, 'Loading...');
              // String result =
              //     await businessPendingAction(item['docID'], 'Declined');
              // evaluateResult(result, context);
            },
            icon: Icon(Icons.close),
            label: Text('Restrict'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, padding: EdgeInsets.all(15)),
          ),
        ],
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 400,
                height: 140,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning_amber_outlined,
                          color: Colors.redAccent,
                        ),
                        Text(
                          'Warning',
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'By clicking the Approve button, you are restricting access to the traveller dashboard for this user account.',
                            textAlign: TextAlign.left,
                            softWrap: true,
                            // Other text style properties can be added here
                          ),
                        ),
                      ],
                    ),
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
