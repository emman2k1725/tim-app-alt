import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/business/advertisement/components/business_ads_dialog.dart';
import 'package:tim_app/pages/business/advertisement/components/business_ads_table.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/details_tabbar.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/paginatedTable.dart';
import 'package:tim_app/pages/profile/profile_edit.dart';
import 'package:tim_app/pages/profile/profile_interest.dart';
import 'package:tim_app/pages/profile/profile_personal_info.dart';
import 'package:tim_app/widgets/customAddButton.dart';

class BusinessAdsScreen extends StatefulWidget {
  const BusinessAdsScreen({super.key});

  @override
  _BusinessAdsScreenViewState createState() => _BusinessAdsScreenViewState();
}

class _BusinessAdsScreenViewState extends State<BusinessAdsScreen> {
  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 3, vsync: this);
  }

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
                          buttonText: 'Add new ads',
                          icon: Icons.add,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => CreateAdsDialog(),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const BusinessAdsTable(),
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
