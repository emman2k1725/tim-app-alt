import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:tim_app/pages/dashboard_menu_components/header.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/responsive.dart';

import '../containers/multidropdown.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(mainBg),
            ),
          ),
          child: Column(
            children: [
              Multidropdown(title: 'dshaghgd'),

              // MultiSelectDialogField(
              //   items: _items,
              //   listType: MultiSelectListType.CHIP,
              //   selectedItemsTextStyle: TextStyle(color: Colors.black),
              //   searchable: true,
              //   // chipDisplay: MultiSelectChipDisplay.none(),
              //   title: Text("Languages"),
              //   selectedColor: Colors.blue,
              //   decoration: BoxDecoration(
              //     color: Colors.blue.withOpacity(0.1),
              //     borderRadius: BorderRadius.all(Radius.circular(40)),
              //     border: Border.all(
              //       color: Colors.blue,
              //       width: 2,
              //     ),
              //   ),
              //   buttonIcon: Icon(
              //     Icons.laptop,
              //     color: Colors.blue,
              //   ),
              //   buttonText: Text(
              //     "Your programming languages",
              //     style: TextStyle(
              //       color: Colors.blue[800],
              //       fontSize: 16,
              //     ),
              //   ),
              //   onConfirm: (results) {
              //     _selectedLanguages = results;
              //     print(_selectedLanguages);
              //     _selectedLanguages.forEach((language) {
              //       print('-----');
              //       print(language.name);
              //     });
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
