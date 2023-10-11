import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/pages/admin/content_management/manage_about/components/manage_video.dart';
import 'package:tim_app/pages/admin/content_management/manage_settings/components/setting_city_table.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:tim_app/widgets/customAddButton.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import 'manage_how_dialog.dart';

class ManageSettingTable extends StatefulWidget {
  const ManageSettingTable({super.key});

  @override
  _ManageSettingTableState createState() => _ManageSettingTableState();
}

class _ManageSettingTableState extends State<ManageSettingTable> {
  late int rowsPerPage = 10;
  List<DataRow> dataRows = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: const Text('Set Content',
              style: TextStyle(
                fontFamily: 'Quicksand', // Specify the font family
                fontSize: 20.0, // Specify the font size
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle
                    .normal, // Specify the font style (e.g., FontStyle.italic for italic text)
                letterSpacing: 1.2, // Specify the letter spacing
                color: Colors.white, // Specify the text color
                // You can also include other properties like decoration, decorationColor, etc.
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ExpansionTile(
            collapsedIconColor: Colors.white,
            title: Text(
              'City Content',
              style: tableHeaderStyle,
            ),
            children: <Widget>[
              SettingCityTable(),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ExpansionTile(
            collapsedIconColor: Colors.white,
            title: Text(
              'Business Type',
              style: tableHeaderStyle,
            ),
            children: <Widget>[
              const ListTile(
                title: Text(
                  'items.description',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ExpansionTile(
            collapsedIconColor: Colors.white,
            title: Text(
              'Advertisement Type',
              style: tableHeaderStyle,
            ),
            children: <Widget>[
              SettingCityTable(),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ExpansionTile(
            collapsedIconColor: Colors.white,
            title: Text(
              'Traveller Type',
              style: tableHeaderStyle,
            ),
            children: <Widget>[
              SettingCityTable(),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ExpansionTile(
            collapsedIconColor: Colors.white,
            title: Text(
              'Cruisines Content',
              style: tableHeaderStyle,
            ),
            children: <Widget>[
              SettingCityTable(),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ExpansionTile(
            collapsedIconColor: Colors.white,
            title: Text(
              'Hangout Content',
              style: tableHeaderStyle,
            ),
            children: <Widget>[
              SettingCityTable(),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ExpansionTile(
            collapsedIconColor: Colors.white,
            title: Text(
              'Interest Content',
              style: tableHeaderStyle,
            ),
            children: <Widget>[
              SettingCityTable(),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}