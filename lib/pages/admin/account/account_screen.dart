import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/account/components/business_account_table.dart';
import 'package:tim_app/pages/admin/manage_travellers/traveller_account_table.dart';
import 'package:tim_app/pages/admin/manage_business/components/admin_application_table.dart';
import 'package:tim_app/pages/admin/manage_business/components/admin_approved_table.dart';
import 'package:tim_app/pages/admin/manage_business/components/admin_declined_table.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/details_tabbar.dart';
import 'package:tim_app/pages/business/special_offers/components/business_offer_dialog.dart';
import 'package:tim_app/pages/travellers/profile/profile_interest.dart';
import 'package:tim_app/widgets/customAddButton.dart';

import '../../../responsive.dart';
import '../../../utils/constants.dart';
import '../admin_table_mobile.dart';

import 'components/admin_account_table.dart';
import 'components/admin_create_account.dart';
import 'components/admin_profile_screen.dart';

class AdminAccountScreen extends StatefulWidget {
  const AdminAccountScreen({super.key});

  @override
  State<AdminAccountScreen> createState() => _AdminAccountScreenState();
}

class _AdminAccountScreenState extends State<AdminAccountScreen>
    with TickerProviderStateMixin {
  Color shadowColor = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
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
                                buttonText: 'Add Admin Account',
                                icon: Icons.add,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AdminCreateAccount(),
                                  );
                                },
                              ),
                            ],
                          )
                        : SizedBox(height: 0),
                    SizedBox(
                      height: Responsive.isDesktop(context) ? 10 : 0,
                    ),
                    Container(
                      child: Align(
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
                                text: "Admin Accounts",
                              ),
                              Tab(
                                text: "Personal Profile",
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Responsive.isDesktop(context)
                              ? SingleChildScrollView(
                                  child: AdminAccountTable())
                              : AdminAccountsDataTableMobile(),
                          Responsive.isDesktop(context)
                              ? AdminProfile()
                              : AdminTableListView(
                                  tableTitle: 'Business Account',
                                  tableTitleColor: Colors.lightBlueAccent,
                                  showAddButton: true,
                                  addButtonToolTip: 'Add admin account',
                                ),
                          // Responsive.isDesktop(context)
                          //     ? TravellerAccountTable()
                          //     : AdminTableListView(
                          //         tableTitle: 'Travellers Accounts',
                          //         tableTitleColor: Colors.lightBlueAccent,
                          //         showAddButton: true,
                          //         addButtonToolTip: 'Add admin account',
                          //       ),
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
