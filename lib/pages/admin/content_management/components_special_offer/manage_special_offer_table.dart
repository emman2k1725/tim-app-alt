import 'package:flutter/material.dart';
import 'package:tim_app/utils/constants.dart';

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
                icon: const Icon(Icons.close),
                onPressed: () {
                  onActionIconSelected(index);
                },
              ),
              IconButton(
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

  // Handle the action when the icon is clicked
  void onActionIconSelected(int rowIndex) {
    // Show a pop-up dialog with the selected row data
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
              icon: Icon(Icons.check),
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
          content: Row(
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
