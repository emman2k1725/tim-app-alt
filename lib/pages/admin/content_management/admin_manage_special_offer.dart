import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/content_management/admin_content_screen.dart';
import 'package:tim_app/pages/admin/content_management/components_special_offer/manage_special_offer_tabbar.dart';
import 'package:tim_app/pages/travellers/apply_business/tabbar.dart';
import 'package:tim_app/pages/business/advertisement/business_ads_screen.dart';
import 'package:tim_app/pages/dashboard_menu_components/header.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:tim_app/widgets/appbar.dart';

class ManageSpecialOffer extends StatelessWidget {
  const ManageSpecialOffer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isApprove = true;
    return Scaffold(
      appBar: CustomAppBar(title: 'Custom AppBar'),
      body: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 1.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(mainBg),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Special Offer',
                    style: AppTextstyle.headerTextStyle,
                  ),
                ],
              ),
              Center(child: const SpecialOfferTabBarView())
            ],
          ),
        ),
      ),
    );
  }
}
