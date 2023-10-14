import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/responsive.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:tim_app/widgets/customAddButton.dart';

class SettingTravellerTable extends StatefulWidget {
  const SettingTravellerTable({super.key});

  @override
  State<SettingTravellerTable> createState() => _SettingTravellerTableState();
}

class _SettingTravellerTableState extends State<SettingTravellerTable>
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
                                buttonText: 'Add Type City',
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
                        : const SizedBox(height: 0),
                    SizedBox(
                      height: Responsive.isDesktop(context) ? 10 : 0,
                    ),
                    Align(
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
                          tabs: const [
                            Tab(
                              text: "List of traveller type",
                            ),
                          ]),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          SingleChildScrollView(
                              child: StreamBuilder(
                            stream: fetchTravellerTypeStream(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                final data = snapshot.data;
                                debugPrint(data.toString());
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
                                            textTheme: const TextTheme(
                                                bodySmall: TextStyle(
                                                    color: Colors.white))),
                                        child: PaginatedDataTable(
                                          arrowHeadColor: Colors.blue,
                                          controller: ScrollController(),
                                          primary: false,
                                          columns: [
                                            DataColumn(
                                              label: Text(
                                                'City Name',
                                                style: tableHeaderStyle,
                                              ),
                                              tooltip: 'City Name',
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Latitude',
                                                style: tableHeaderStyle,
                                              ),
                                              tooltip: 'Latitude',
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Longitude',
                                                style: tableHeaderStyle,
                                              ),
                                              tooltip: 'Longitude',
                                            ),
                                          ],
                                          source:
                                              _MyDataTableSource(data, context),
                                        ),
                                      );
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
        item['city'].toString(),
        overflow: TextOverflow.visible,
        softWrap: true,
        style: tableContentStyle,
      )),
      DataCell(
        Container(
          constraints: const BoxConstraints(maxWidth: 150),
          child: Text(
            item['lat'].toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: tableContentStyle,
          ),
        ),
      ),
      DataCell(
        Container(
          constraints: const BoxConstraints(maxWidth: 150),
          child: Text(
            item['long'].toString(),
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
