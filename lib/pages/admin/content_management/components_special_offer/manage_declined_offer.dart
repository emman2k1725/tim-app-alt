import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';

import 'manage_offer_modal.dart';

class ManageDeclinedOffer extends StatefulWidget {
  const ManageDeclinedOffer({super.key});

  @override
  _ManageDeclinedOfferState createState() => _ManageDeclinedOfferState();
}

class _ManageDeclinedOfferState extends State<ManageDeclinedOffer> {
  @override
  Widget build(BuildContext context) {
    final int rowsPerPage = 10;
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: fetchOffers('Declined'),
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
                              'Title',
                              style: tableHeaderStyle,
                            ),
                          ],
                        ),
                        tooltip: 'title',
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
                          'Created At',
                          style: tableHeaderStyle,
                        ),
                        tooltip: 'Created At',
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

    DateTime parsedDate = DateTime.parse(item['createAt']);
    String formattedDate = DateFormat('MMM dd, yyyy').format(parsedDate);

    return DataRow(cells: [
      DataCell(Text(
        item['businessName'].toString(),
        style: tableContentStyle,
      )),
      DataCell(Text(
        item['title'].toString(),
        style: tableContentStyle,
      )),
      DataCell(Text(
        item['offerCode'].toString(),
        style: tableContentStyle,
      )),
      DataCell(Text(
        formattedDate,
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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ManageOfferModal(
                      item: item,
                    );
                  },
                );
              },
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
