import 'package:flutter/material.dart';
import 'package:tim_app/pages/travellers/dashboard/traveller_dashboard_screen_body.dart';

import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class TravellerDashboard extends StatelessWidget {
  const TravellerDashboard({super.key});

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Admin Dashboard'),
      body: SingleChildScrollView(
        primary: false,
        child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(mainBg),
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TravellerDashboardBody())),
      ),
    );
  }
}
