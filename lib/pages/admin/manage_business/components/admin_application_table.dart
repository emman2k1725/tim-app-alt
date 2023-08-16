import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/manage_business/operating_hours.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/business_links.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/thumbnail.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';

import '../../../../utils/loading.dart';

class BusinessApplicationTable extends StatefulWidget {
  const BusinessApplicationTable({super.key});

  @override
  State<BusinessApplicationTable> createState() =>
      _BusinessApplicationTableState();
}

class _BusinessApplicationTableState extends State<BusinessApplicationTable> {
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
          return PaginatedDataTable(
            header: Text(
              'Business Application',
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
                      'Business Sector',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                tooltip: 'Business Sector',
              ),
              DataColumn(
                label: Text(
                  'Country',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                tooltip: 'Country',
              ),
              const DataColumn(
                label: Text(
                  'Action',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                tooltip: '',
              ),
              // Add more columns as needed
            ],
            source: _MyDataTableSource(data, context),

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
          icon: const Icon(Icons.visibility),
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
        title: const Text('Business Details'),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              showCustomLoadingDialog(context, 'Loading...');
              String result =
                  await businessPendingAction(item['docID'], 'Approved');
              evaluateResult(result, context);
            },
            icon: Icon(Icons.check),
            label: Text('Approve'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, padding: EdgeInsets.all(20)),
          ),
          SizedBox(width: 8), // Add some space between the buttons
          ElevatedButton.icon(
            onPressed: () async {
              showCustomLoadingDialog(context, 'Loading...');
              String result =
                  await businessPendingAction(item['docID'], 'Declined');
              evaluateResult(result, context);
            },
            icon: Icon(Icons.close),
            label: Text('Decline'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, padding: EdgeInsets.all(20)),
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
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          item['businessEmail']
                              .toString(), // Replace with your name or text
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          item['businessDesc']
                              .toString(), // Replace with your name or text
                          style: TextStyle(
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
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          item['businessAddress']['country']
                              .toString(), // Replace with your name or text
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          item['businessPhoneNumber']['countryCode']
                                  .toString() +
                              item['businessPhoneNumber']['number']
                                  .toString(), // Replace with your name or text
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Business Thumbnail', // Replace with your name or text
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Business Address', // Replace with your name or text
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        SizedBox(
                          width: 500,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Country', // Replace with your name or text
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                item['businessAddress'][
                                    'country'], // Replace with your name or text
                                style: TextStyle(
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
                              Text(
                                'City', // Replace with your name or text
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                item['businessAddress']
                                    ['city'], // Replace with your name or text
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        SizedBox(
                          width: 500,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Postal Code', // Replace with your name or text
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                item['businessAddress'][
                                    'postal'], // Replace with your name or text
                                style: TextStyle(
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
                              Text(
                                'Building Address', // Replace with your name or text
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                item['businessAddress'][
                                    'building'], // Replace with your name or text
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Business Links', // Replace with your name or text
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    BusinessLinks(item: item),
                    SizedBox(height: 20.0),
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
