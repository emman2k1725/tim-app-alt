// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/admin_table_mobile.dart';
import 'package:tim_app/pages/admin/manage_business/components/admin_application_table.dart';
import 'package:tim_app/pages/admin/manage_business/components/admin_approved_table.dart';
import 'package:tim_app/pages/admin/manage_business/components/admin_declined_table.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/details_tabbar.dart';
import 'package:tim_app/pages/profile/profile_interest.dart';
import 'package:tim_app/utils/responsive.dart';

import '../../../utils/constants.dart';
import '../content_management/manage_media/components/manage_media_table.dart';

class ManageBusinessScreen extends StatefulWidget {
  const ManageBusinessScreen({super.key});

  @override
  State<ManageBusinessScreen> createState() => _ManageBusinessScreenState();
}

class _ManageBusinessScreenState extends State<ManageBusinessScreen>
    with TickerProviderStateMixin {
  Color shadowColor = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
        height: h,
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
                    Align(
                      alignment: Responsive.isDesktop(context)
                          ? Alignment.centerLeft
                          : Alignment.center,
                      child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          labelPadding:
                              const EdgeInsets.only(left: 20, right: 20),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(
                              text: "Pending Application",
                            ),
                            Tab(
                              text: "Approved Business",
                            ),
                            Tab(
                              text: "Declined Business",
                            )
                          ]),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Responsive.isDesktop(context)
                              ? SingleChildScrollView(
                                  child: BusinessApplicationTable())
                              : ManageBusinessDataTableMobile(
                                  applicationStatus: 'Pending',
                                ),
                          Responsive.isDesktop(context)
                              ? SingleChildScrollView(
                                  child: BusinessApprovedTable())
                              : ManageBusinessDataTableMobile(
                                  applicationStatus: 'Approved',
                                ),
                          Responsive.isDesktop(context)
                              ? SingleChildScrollView(
                                  child: BusinessDeclinedTable())
                              : ManageBusinessDataTableMobile(
                                  applicationStatus: 'Declined',
                                ),
                        ],
                      ),
                    )
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
