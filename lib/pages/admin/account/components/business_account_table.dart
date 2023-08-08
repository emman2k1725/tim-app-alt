import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/manage_business/operating_hours.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/business_links.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/thumbnail.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';

import '../../../../utils/loading.dart';

class BusinessAccountTable extends StatefulWidget {
  const BusinessAccountTable({super.key});

  @override
  State<BusinessAccountTable> createState() => _BusinessAccountTableState();
}

class _BusinessAccountTableState extends State<BusinessAccountTable> {
  @override
  Widget build(BuildContext context) {
    final int rowsPerPage = 10;
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchData('businesses'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching data'));
        } else if (snapshot.hasData) {
          List<Map<String, dynamic>> data = snapshot.data!;
          return SingleChildScrollView(
            child: PaginatedDataTable(
              header: Text(
                'Business Account',
                style: TextStyle(color: Colors.lightBlueAccent),
              ),
              rowsPerPage: rowsPerPage,
              columns: [
                DataColumn(
                  label: Row(
                    children: [
                      const Text(
                        'Business Name',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  tooltip: 'Business Name',
                ),
                DataColumn(
                  label: Row(
                    children: [
                      const Text(
                        'Business Email',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  tooltip: 'Business Email',
                ),
                DataColumn(
                  label: Row(
                    children: [
                      const Text(
                        'Phone Number',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  tooltip: 'Phone Number',
                ),
                DataColumn(
                  label: Text(
                    'Business Sector',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  tooltip: 'Business Sector',
                ),
                DataColumn(
                  label: Text(
                    'Action',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  tooltip: 'Action',
                ),
                // Add more columns as needed
              ],
              source: _MyDataTableSource(data, context),
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
      DataCell(Text(item['businessName'].toString())),
      DataCell(Text(item['businessEmail'].toString())),
      DataCell(Text(item['businessSector'].toString())),
      DataCell(Text(item['businessAddress']['country'].toString())),
      DataCell(
        IconButton(
          icon: const Icon(Icons.no_accounts),
          onPressed: () {
            // Call the onActionIconSelected callback when the icon is clicked
            _showRowDialog(item, context);
          },
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
        title: const Text('Business Account'),
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
                            'By clicking the Approve button, you are restricting access to the business dashboard for this user account.',
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
