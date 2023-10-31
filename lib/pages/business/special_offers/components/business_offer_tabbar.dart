// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/business_reviews.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/details_tabbar.dart';
import 'package:tim_app/pages/admin/manage_business/components/admin_application_table.dart';
import 'package:tim_app/pages/business/special_offers/components/business_offer_table.dart';
import 'package:tim_app/pages/travellers/profile/profile_edit.dart';
import 'package:tim_app/pages/travellers/profile/profile_interest.dart';
import 'package:tim_app/pages/travellers/profile/profile_personal_info.dart';
import 'package:tim_app/pages/travellers/travel_history/components/trip_history.dart';
import 'package:tim_app/pages/travellers/travel_history/components/trip_rated_list.dart';

class BusinessOfferTabbar extends StatefulWidget {
  const BusinessOfferTabbar({super.key});

  @override
  _BusinessOfferTabbarState createState() => _BusinessOfferTabbarState();
}

class _BusinessOfferTabbarState extends State<BusinessOfferTabbar>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 3, vsync: this);
  }

  Color shadowColor = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 1, vsync: this);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelPadding: const EdgeInsets.only(left: 20, right: 20),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: "Special Offers",
                  ),
                ]),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue, // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            width: double.maxFinite,
            height: ((MediaQuery.of(context).size.height) * 0.80),
            child: TabBarView(
              controller: _tabController,
              children: [SingleChildScrollView(child: BusinessOfferTable())],
            ),
          ),
        ],
      ),
    );
  }
}
