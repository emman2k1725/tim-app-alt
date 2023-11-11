import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/manage_business/operating_hours.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/business_links.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/thumbnail.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:tim_app/widgets/dialogs/success_dialog.dart';

import '../../../../utils/loading.dart';
import '../components_view_business/modal_tabbar_business.dart';

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
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: fetchTableBusiness('Pending'),
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
                      'Business Application',
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                    rowsPerPage: rowsPerPage,
                    columns: [
                      DataColumn(
                        label: Row(
                          children: [
                            Text(
                              'Business Name',
                              style: tableHeaderStyle,
                            ),
                          ],
                        ),
                        tooltip: 'Business Name',
                      ),
                      DataColumn(
                        label: Row(
                          children: [
                            Text(
                              'Business Email',
                              style: tableHeaderStyle,
                            ),
                          ],
                        ),
                        tooltip: 'Business Email',
                      ),
                      DataColumn(
                        label: Row(
                          children: [
                            Text(
                              'Business Sector',
                              style: tableHeaderStyle,
                            ),
                          ],
                        ),
                        tooltip: 'Business Sector',
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
                        tooltip: '',
                      ),
                      // Add more columns as needed
                    ],
                    source: _MyDataTableSource(data!, context),
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
      DataCell(Text(
        item['businessName'].toString(),
        style: tableContentStyle,
      )),
      DataCell(Text(
        item['businessEmail'].toString(),
        style: tableContentStyle,
      )),
      DataCell(Text(
        item['businessSector'].toString(),
        style: tableContentStyle,
      )),
      DataCell(Text(
        item['businessAddress']['country'].toString(),
        style: tableContentStyle,
      )),
      DataCell(
        IconButton(
          icon: const Icon(
            Icons.visibility,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ModalTabbarBusiness(
                  item: item,
                );
              },
            );
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
