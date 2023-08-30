import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/backend/firebase/businessDataProvider.dart';
import 'package:tim_app/backend/firebase/firebaseService.dart';
import 'package:tim_app/pages/travellers/apply_business/tabbar.dart';
import 'package:tim_app/pages/dashboard_menu_components/header.dart';
import 'package:tim_app/pages/travellers/traveller_plan/travel_plan_kanban.dart';
import 'package:tim_app/pages/travellers/traveller_plan/traveller_plan_search.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';
import 'package:tim_app/widgets/blurContainer.dart';
import 'package:tim_app/widgets/customButtons.dart';

class TravellerPlanScreen extends StatelessWidget {
  const TravellerPlanScreen({super.key});

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Admin Dashboard'),
      body: SingleChildScrollView(
        primary: false,
        child: Container(
            height: 600,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(mainBg),
              ),
            ),
            child: const Padding(
                padding: EdgeInsets.all(8.0), child: TravelPlanSearch())),
      ),
    );
  }
}
