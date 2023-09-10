import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/content_management/manage_city_guide/components/manage_cityGuide_dialog.dart';
import 'package:tim_app/pages/admin/content_management/manage_city_guide/components/manage_cityGuide_table.dart';
import 'package:tim_app/widgets/customAddButton.dart';

class ManageCityGuideScreen extends StatefulWidget {
  const ManageCityGuideScreen({super.key});

  @override
  _ManageCityGuideScreenState createState() => _ManageCityGuideScreenState();
}

class _ManageCityGuideScreenState extends State<ManageCityGuideScreen> {
  Color shadowColor = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AddButton(
                          buttonText: 'Add New City Guide',
                          icon: Icons.add,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => CreateCityGuideDialog(),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const ManageCityGuideTable(),
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