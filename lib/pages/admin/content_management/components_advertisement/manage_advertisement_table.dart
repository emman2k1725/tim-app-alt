import 'package:flutter/material.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';

class ManageAdvertisementTable extends StatefulWidget {
  const ManageAdvertisementTable({super.key});

  @override
  _ManageAdvertisementTableState createState() =>
      _ManageAdvertisementTableState();
}

class _ManageAdvertisementTableState extends State<ManageAdvertisementTable> {
  @override
  Widget build(BuildContext context) {
    final int rowsPerPage = 10;
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: fetchTableCollection('advertisement'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching data'));
        } else if (snapshot.hasData) {
          final data = snapshot.data;

          return data!.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'No data available.',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Theme(
                  data: Theme.of(context).copyWith(
                      cardColor: Colors.white60.withOpacity(0.10),
                      dividerColor: Colors.blue,
                      textTheme:
                          TextTheme(bodySmall: TextStyle(color: Colors.white))),
                  child: PaginatedDataTable(
                    header: Text(
                      'Admin Account',
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                    rowsPerPage: rowsPerPage,
                    columns: [
                      DataColumn(
                        label: Row(
                          children: [
                            Text(
                              'Name',
                              style: tableHeaderStyle,
                            ),
                          ],
                        ),
                        tooltip: 'Name',
                      ),
                      DataColumn(
                        label: Row(
                          children: [
                            Text(
                              'Email',
                              style: tableHeaderStyle,
                            ),
                          ],
                        ),
                        tooltip: 'Email',
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
                          'Position',
                          style: tableHeaderStyle,
                        ),
                        tooltip: 'Position',
                      ),
                      DataColumn(
                        label: Text(
                          'Action',
                          style: tableHeaderStyle,
                        ),
                        tooltip: 'Action',
                      ),
                    ],
                    source: _MyDataTableSource(data!, context),
                  ));
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
      DataCell(Text(
        item['business'].toString(),
        style: tableContentStyle,
      )),
      DataCell(Text(
        item['title'].toString(),
        style: tableContentStyle,
      )),
      DataCell(Text(
        item['placement'].toString(),
        style: tableContentStyle,
      )),
      DataCell(Text(
        item['createAt'].toString(),
        style: tableContentStyle,
      )),
      DataCell(
        Row(
          children: [
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
