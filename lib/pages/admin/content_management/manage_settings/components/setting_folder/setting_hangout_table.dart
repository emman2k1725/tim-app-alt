import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/responsive.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:tim_app/widgets/customAddButton.dart';
import 'package:url_launcher/link.dart';

class SettingHangoutTable extends StatefulWidget {
  const SettingHangoutTable({super.key});

  @override
  State<SettingHangoutTable> createState() => _SettingHangoutTableState();
}

class _SettingHangoutTableState extends State<SettingHangoutTable>
    with TickerProviderStateMixin {
  Color shadowColor = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 1, vsync: this);
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
        height: 800,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  for (double i = 1; i < 5; i++)
                    BoxShadow(
                      spreadRadius: -1,
                      color: shadowColor,
                      blurRadius: 1,
                      blurStyle: BlurStyle.outer,
                    )
                ],
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white60.withOpacity(0.10),
                      Colors.blue.withOpacity(0.10)
                    ]),
                // color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(width: 2, color: Colors.white10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Responsive.isDesktop(context)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AddButton(
                                buttonText: 'Add New Hangout',
                                icon: Icons.add,
                                onPressed: () {
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (context) => CreateMediaDialog(),
                                  // );
                                },
                              ),
                            ],
                          )
                        : SizedBox(height: 0),
                    SizedBox(
                      height: Responsive.isDesktop(context) ? 10 : 0,
                    ),
                    Container(
                      child: Align(
                        alignment: Responsive.isDesktop(context)
                            ? Alignment.centerLeft
                            : Alignment.center,
                        child: TabBar(
                            controller: tabController,
                            isScrollable: true,
                            labelPadding:
                                const EdgeInsets.only(left: 20, right: 20),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Tab(
                                text: "List of Hangout Places",
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          SingleChildScrollView(
                              child: StreamBuilder(
                            stream: fetchHangoutStream(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return const Center(
                                    child: Text('Error fetching data'));
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
                                            cardColor: Colors.white60
                                                .withOpacity(0.10),
                                            dividerColor: Colors.blue,
                                            textTheme: TextTheme(
                                                bodySmall: TextStyle(
                                                    color: Colors.white))),
                                        child: PaginatedDataTable(
                                          arrowHeadColor: Colors.blue,
                                          controller: ScrollController(),
                                          primary: false,
                                          columns: [
                                            DataColumn(
                                              label: Text(
                                                'Hangout Place',
                                                style: tableHeaderStyle,
                                              ),
                                              tooltip: 'Hangout Place',
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Average Time Spent',
                                                style: tableHeaderStyle,
                                              ),
                                              tooltip: 'Average Time',
                                            ),
                                          ],
                                          source:
                                              _MyDataTableSource(data, context),
                                        ),
                                      );
                              } else {
                                return const Center(
                                    child: Text('No data found'));
                              }
                            },
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
        item['hangout'].toString(),
        overflow: TextOverflow.visible,
        softWrap: true,
        style: tableContentStyle,
      )),
      DataCell(
        Container(
          constraints: const BoxConstraints(maxWidth: 150),
          child: Text(
            item['ave_time_mins'].toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: tableContentStyle,
          ),
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
