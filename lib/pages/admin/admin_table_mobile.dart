// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tim_app/utils/responsive.dart';
import 'package:tim_app/widgets/blurContainer.dart';

import '../../backend/firebase/fetchTable.dart';
import '../../utils/loading.dart';
import '../../widgets/customAddButton.dart';
import '../business/advertisement/components/business_ads_dialog.dart';
import '../business/business_details/tabbar_components/business_links.dart';
import '../business/business_details/tabbar_components/thumbnail.dart';
import 'manage_business/operating_hours.dart';

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
                                  builder: (context) => CreateAdsDialog(
                                    business: null,
                                  ),
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
                                  builder: (context) => CreateAdsDialog(
                                    business: null,
                                  ),
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
                                onPressed: () =>
                                    _showRowDialogMobile(data[index], context),
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

class AdminAccountsDataTableMobile extends StatefulWidget {
  const AdminAccountsDataTableMobile({super.key});

  @override
  State<AdminAccountsDataTableMobile> createState() =>
      _AdminAccountsDataTableMobileState();
}

class _AdminAccountsDataTableMobileState
    extends State<AdminAccountsDataTableMobile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: fetchTableAdminAccount(true),
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
                                        'Name',
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
                                        'Email',
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
                                        'Position',
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

void _showRowDialogMobile(Map<String, dynamic> item, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Business Details'),
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
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Container(
                            width:
                                100, // Set the desired width for the circular avatar
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    Colors.blue, // Set the color of the border
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
                              item['businessSector'].toString(),
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
                              item['businessEmail'].toString(),
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
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      item['businessDesc'].toString(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text(
                      'Country', // Replace with your name or text
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      item['businessAddress']
                          ['country'], // Replace with your name or text
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'City', // Replace with your name or text
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      item['businessAddress']
                          ['city'], // Replace with your name or text
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Postal Code', // Replace with your name or text
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      item['businessAddress']
                          ['postal'], // Replace with your name or text
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Building Address', // Replace with your name or text
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      item['businessAddress']
                          ['building'], // Replace with your name or text
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
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
