import 'package:flutter/material.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/dialogs/success_dialog.dart';

class ManageOfferTable extends StatefulWidget {
  const ManageOfferTable({super.key});

  @override
  _ManageOfferTableState createState() => _ManageOfferTableState();
}

class _ManageOfferTableState extends State<ManageOfferTable> {
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
          Row(
            children: [
              IconButton(
                color: Colors.blue,
                icon: const Icon(Icons.image),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SuccessDialog(
                        title: 'Hello',
                      );
                    },
                  );
                },
                // onPressed: () {
                //   actionImage(index);
                // },
              ),
              IconButton(
                color: Colors.redAccent,
                icon: const Icon(Icons.close),
                onPressed: () {
                  actionDecline(index);
                },
              ),
              IconButton(
                color: Colors.green,
                icon: const Icon(Icons.check),
                onPressed: () {
                  onActionIconSelected(index);
                },
              ),
            ],
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

  void actionImage(int rowIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Special Offers Image'),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              label: Text('Go back'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, padding: EdgeInsets.all(20)),
            ),
          ],
          content: Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue, // Set the border color to blue
                width: 2.0, // Set the border width
              ),
            ),
            child: Image.asset(
              logo, // Replace this with the actual image path
              width: 200,
              height: 200,
            ),
          ),
        );
      },
    );
  }

  void actionDecline(int rowIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Special Offer Application'),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              label: Text('Back'),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(20)),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.check),
              label: Text('Approve'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, padding: EdgeInsets.all(20)),
            ),
          ],
          content: const Row(
            children: [
              Icon(Icons.notification_important_outlined),
              Text('Do you wish to proceed with declining this application?'),
            ],
          ),
        );
      },
    );
  }

  void onActionIconSelected(int rowIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Special Offer Application'),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              label: Text('Back'),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(20)),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.check),
              label: Text('Approve'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, padding: EdgeInsets.all(20)),
            ),
          ],
          content: const Row(
            children: [
              Icon(Icons.notification_important_outlined),
              Text('Do you wish to proceed with approving this application?'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        columns: [
          DataColumn(
            label: Row(
              children: [
                const Text('Company Name'),
                if (_sortColumnIndex == 2)
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
                const Text('Title'),
                if (_sortColumnIndex == 0)
                  Icon(_sortAscending
                      ? Icons.arrow_upward
                      : Icons.arrow_downward),
              ],
            ),
            tooltip: 'Title',
            onSort: (columnIndex, ascending) {
              _sortData(columnIndex, ascending);
            },
          ),
          DataColumn(
            label: Row(
              children: [
                const Text('Offer Code'),
                if (_sortColumnIndex == 1)
                  Icon(_sortAscending
                      ? Icons.arrow_upward
                      : Icons.arrow_downward),
              ],
            ),
            tooltip: 'Offer Code',
            onSort: (columnIndex, ascending) {
              _sortData(columnIndex, ascending);
            },
          ),
          DataColumn(
            label: Row(
              children: [
                const Text('Description'),
                if (_sortColumnIndex == 2)
                  Icon(_sortAscending
                      ? Icons.arrow_upward
                      : Icons.arrow_downward),
              ],
            ),
            tooltip: 'Description',
            onSort: (columnIndex, ascending) {
              _sortData(columnIndex, ascending);
            },
          ),
          const DataColumn(
            label: Text('Action'),
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
