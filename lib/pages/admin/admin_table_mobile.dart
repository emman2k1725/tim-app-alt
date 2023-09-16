// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tim_app/utils/responsive.dart';
import 'package:tim_app/widgets/blurContainer.dart';

import '../../backend/firebase/fetchTable.dart';
import '../../widgets/customAddButton.dart';
import '../business/advertisement/components/business_ads_dialog.dart';

class AdminTableListView extends StatefulWidget {
  final String tableTitle;
  final Color tableTitleColor;
  final bool showAddButton;
  final String addButtonToolTip;

  const AdminTableListView(
      {super.key,
      required this.tableTitle,
      required this.tableTitleColor,
      required this.showAddButton,
      required this.addButtonToolTip});

  @override
  State<AdminTableListView> createState() => _AdminTableListViewState();
}

class _AdminTableListViewState extends State<AdminTableListView> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Adjust the value as needed
          color: Colors.white,
          // Add other decoration properties if needed
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: widget.showAddButton == false
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.tableTitle, //'Business Application',
                        style: TextStyle(
                            color: widget.tableTitleColor,
                            fontSize: Responsive.isMobile(context) ? 15 : 20),
                      ),
                      widget.showAddButton == false
                          ? SizedBox(height: 0)
                          : AddButton2(
                              toolTip: widget.addButtonToolTip,
                              icon: Icons.add,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => CreateAdsDialog(),
                                );
                              })
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: items
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: 160,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            // border: Border.all(
                            //   color: Colors.black26,
                            // ),
                            color: Colors.white,
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down_outlined,
                          ),
                          iconSize: 25,
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white,
                          ),
                          offset: const Offset(0, -5),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: 10,
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.grey),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text(
                          "$selectedValue.$index" ??
                              'No item selected', // Use the selected value in the Text widget
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
                /* Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.grey),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Text(
                            "$selectedValue.$index" ??
                                'No item selected', // Use the selected value in the Text widget
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                    ),
                  ),
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdminTableListView2 extends StatefulWidget {
  final List<String> columnTitleList;
  final String tableTitle;
  final Color tableTitleColor;
  final bool showAddButton;
  final String addButtonToolTip;

  const AdminTableListView2(
      {super.key,
      required this.columnTitleList,
      required this.tableTitle,
      required this.tableTitleColor,
      required this.showAddButton,
      required this.addButtonToolTip});

  @override
  State<AdminTableListView2> createState() => _AdminTableListView2State();
}

class _AdminTableListView2State extends State<AdminTableListView2> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Adjust the value as needed
          color: Colors.white,
          // Add other decoration properties if needed
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: widget.showAddButton == false
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.tableTitle, //'Business Application',
                        style: TextStyle(
                            color: widget.tableTitleColor,
                            fontSize: Responsive.isMobile(context) ? 15 : 20),
                      ),
                      widget.showAddButton == false
                          ? SizedBox(height: 0)
                          : AddButton2(
                              toolTip: widget.addButtonToolTip,
                              icon: Icons.add,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => CreateAdsDialog(),
                                );
                              })
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: widget.columnTitleList
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: 160,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            // border: Border.all(
                            //   color: Colors.black26,
                            // ),
                            color: Colors.white,
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down_outlined,
                          ),
                          iconSize: 25,
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white,
                          ),
                          offset: const Offset(0, -5),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: 10,
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.grey),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text(
                          "$selectedValue.$index" ??
                              'No item selected', // Use the selected value in the Text widget
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
                /* Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.grey),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Text(
                            "$selectedValue.$index" ??
                                'No item selected', // Use the selected value in the Text widget
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                    ),
                  ),
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ManageBusinessDataTableMobile extends StatefulWidget {
  final String applicationStatus;
  const ManageBusinessDataTableMobile(
      {super.key, required this.applicationStatus});

  @override
  State<ManageBusinessDataTableMobile> createState() =>
      _ManageBusinessDataTableMobileState();
}

class _ManageBusinessDataTableMobileState
    extends State<ManageBusinessDataTableMobile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: fetchTableBusiness(widget.applicationStatus),
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
              : ListView.separated(
                  shrinkWrap: true,
                  itemCount: data.length,
                  separatorBuilder: ((context, index) => SizedBox(
                        height: 15,
                      )),
                  itemBuilder: ((context, index) {
                    return BlurContainer(
                      childColumn: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Business Name',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                      Text(
                                        data[index]['businessName'].toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Business Sector',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                      Text(
                                        data[index]['businessSector']
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Business Email',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                      Text(
                                        data[index]['businessEmail'].toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Country',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                      Text(
                                        data[index]['businessAddress']
                                                ['country']
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Divider(
                              color: Colors.white,
                              thickness: 0.5,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'View more details',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      ),
                    );
                  }));
        } else {
          return Center(child: Text('No data found'));
        }
      },
    );
  }
}

class ManageTravellerDataTableMobile extends StatefulWidget {
  const ManageTravellerDataTableMobile({super.key});

  @override
  State<ManageTravellerDataTableMobile> createState() =>
      _ManageTravellerDataTableMobileState();
}

class _ManageTravellerDataTableMobileState
    extends State<ManageTravellerDataTableMobile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: fetchTableAdminAccount(false),
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
              : ListView.separated(
                  shrinkWrap: true,
                  itemCount: data.length,
                  separatorBuilder: ((context, index) => SizedBox(
                        height: 15,
                      )),
                  itemBuilder: ((context, index) {
                    return BlurContainer(
                      childColumn: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Traveller Name',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                      Text(
                                        data[index]['firstName'].toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Traveller Email',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                      Text(
                                        data[index]['email'].toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Phone Number',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                      Text(
                                        data[index]['mobileNumber'].toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Country',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                      Text(
                                        data[index]['nationality'].toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Divider(
                              color: Colors.white,
                              thickness: 0.5,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'View more details',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      ),
                    );
                  }));
        } else {
          return Center(child: Text('No data found'));
        }
      },
    );
  }
}
