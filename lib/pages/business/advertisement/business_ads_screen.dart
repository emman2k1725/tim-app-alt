// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/model/BusinessModel.dart';
import 'package:tim_app/pages/business/advertisement/components/business_ads_dialog.dart';
import 'package:tim_app/pages/business/advertisement/components/business_ads_tabbar.dart';
import 'package:tim_app/pages/business/advertisement/components/business_ads_table.dart';
import 'package:tim_app/utils/responsive.dart';
import 'package:tim_app/widgets/customAddButton.dart';

import '../business_table_mobile.dart';

class BusinessAdsScreen extends StatefulWidget {
  const BusinessAdsScreen({super.key});

  @override
  _BusinessAdsScreenViewState createState() => _BusinessAdsScreenViewState();
}

class _BusinessAdsScreenViewState extends State<BusinessAdsScreen> {
  BusinessModel? business;
  @override
  void initState() {
    super.initState();
    loadNewLaunch();
  }

  loadNewLaunch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('business') != null) {
      setState(() {
        business = BusinessModel.fromMapWithID(
            jsonDecode(pref.getString('business')!));
      });
    }
  }

  Color shadowColor = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SizedBox(
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
                child: Responsive.isMobile(context)
                    ? BusinessDetailsListView()
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AddButton(
                                  buttonText: 'Create new ads',
                                  icon: Icons.add,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => CreateAdsDialog(
                                          businessID: business?.businessID),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(child: BusinessAdsTabbar())
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
