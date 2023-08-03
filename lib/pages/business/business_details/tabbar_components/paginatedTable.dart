import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tim_app/pages/admin/manage_business/operating_hours.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/business_links.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/thumbnail.dart';
import 'package:tim_app/utils/constants.dart';

class PaginatedDataTableDemo extends StatefulWidget {
  const PaginatedDataTableDemo({super.key});

  @override
  _PaginatedDataTableDemoState createState() => _PaginatedDataTableDemoState();
}

class _PaginatedDataTableDemoState extends State<PaginatedDataTableDemo> {
  late int rowsPerPage = 10;
  List<DataRow> dataRows = [];

  @override
  void initState() {
    super.initState();
    // Generate data rows after initializing the sort and dataRows
    dataRows = List.generate(
      100, // Replace with your actual data size
      (index) => DataRow(cells: [
        DataCell(Text('Row ${index + 1} - Column 1')),
        DataCell(Text('Row ${index + 1} - Column 2')),
        DataCell(Text('Row ${index + 1} - Column 3')),
        DataCell(Text('Row ${index + 1} - Column 4')),
        DataCell(
          IconButton(
            icon: const Icon(Icons.view_carousel_outlined),
            onPressed: () {
              // Call the onActionIconSelected callback when the icon is clicked
              onActionIconSelected(index);
            },
          ),
        ),
      ]),
    );
  }

  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  void _sortData(int columnIndex, bool ascending) {
    dataRows.sort((a, b) {
      final aValue = a.cells[columnIndex].child.toString();
      final bValue = b.cells[columnIndex].child.toString();
      return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
    });

    setState(() {
      _sortAscending = ascending;
      _sortColumnIndex = columnIndex;
    });
  }

  // Handle the action when the icon is clicked
  void onActionIconSelected(int rowIndex) {
    // Show a pop-up dialog with the selected row data
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Business Details'),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                // Implement approve logic here
              },
              icon: Icon(Icons.check),
              label: Text('Approve'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, padding: EdgeInsets.all(20)),
            ),
            SizedBox(width: 8), // Add some space between the buttons
            ElevatedButton.icon(
              onPressed: () {
                // Implement decline logic here
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
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 1.0,
                            ),
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage(businessProfile),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                        height: 15,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Seafood Overload',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'johndoe@gmail.com', // Replace with your name or text
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Indulge in a culinary voyage at our seafood restaurant, \nWhere ocean-fresh delicacies are expertly prepared to delight your taste buds.\nUnforgettable flavors await!', // Replace with your name or text
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sector', // Replace with your name or text
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Country', // Replace with your name or text
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Phone number', // Replace with your name or text
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
                      ImageRowPage(),
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
                                  'Country', // Replace with your name or text
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
                                  'City', // Replace with your name or text
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
                                  'Postal Code', // Replace with your name or text
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
                                  'Building Address', // Replace with your name or text
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
                      BusinessLinks(),
                      SizedBox(height: 20.0),
                      Align(
                          alignment: Alignment.topLeft,
                          child: OperatingHours()),
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        // ... existing code ...

        columns: [
          DataColumn(
            label: Row(
              children: [
                const Text('Company Name'),
                if (_sortColumnIndex == 0)
                  Icon(_sortAscending
                      ? Icons.arrow_upward
                      : Icons.arrow_downward),
              ],
            ),
            tooltip: 'Company Name',
            onSort: (columnIndex, ascending) {
              _sortData(columnIndex, ascending);
            },
          ),
          DataColumn(
            label: Row(
              children: [
                const Text('Company Email'),
                if (_sortColumnIndex == 1)
                  Icon(_sortAscending
                      ? Icons.arrow_upward
                      : Icons.arrow_downward),
              ],
            ),
            tooltip: 'Company Email',
            onSort: (columnIndex, ascending) {
              _sortData(columnIndex, ascending);
            },
          ),
          DataColumn(
            label: Row(
              children: [
                const Text('Business Sector'),
                if (_sortColumnIndex == 2)
                  Icon(_sortAscending
                      ? Icons.arrow_upward
                      : Icons.arrow_downward),
              ],
            ),
            tooltip: 'Business Sector',
            onSort: (columnIndex, ascending) {
              _sortData(columnIndex, ascending);
            },
          ),
          DataColumn(
            label: Text('Country'),
            tooltip: 'Country',
            onSort: (columnIndex, ascending) {
              _sortData(columnIndex, ascending);
            },
          ),
          const DataColumn(
            label: Text('Action'),
            // Hide the default tooltip by setting it to an empty string
            tooltip: '',
          ),
        ],

        source: _MyDataTableSource(dataRows, _sortColumnIndex, _sortAscending),
      ),
    );
  }
}

class _MyDataTableSource extends DataTableSource {
  final List<DataRow> dataRows;
  final int sortColumnIndex;
  final bool sortAscending;

  _MyDataTableSource(this.dataRows, this.sortColumnIndex, this.sortAscending);

  @override
  DataRow? getRow(int index) {
    if (index >= dataRows.length) return null;
    return dataRows[index];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataRows.length;

  @override
  int get selectedRowCount => 0;
}
