import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/content_management/manage_settings/components/manage_setting_table.dart';

class ManageSettingScreen extends StatefulWidget {
  const ManageSettingScreen({super.key});

  @override
  _ManageSettingScreenState createState() => _ManageSettingScreenState();
}

class _ManageSettingScreenState extends State<ManageSettingScreen> {
  Color shadowColor = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
        width: double.maxFinite,
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
                    const ManageSettingTable(),
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
