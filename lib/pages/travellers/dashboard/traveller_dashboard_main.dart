import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/pages/travellers/dashboard/traveller_dashboard_screen_body.dart';

import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class TravellerDashboard extends StatefulWidget {
  const TravellerDashboard({super.key});

  @override
  State<TravellerDashboard> createState() => _TravellerDashboardState();
}

class _TravellerDashboardState extends State<TravellerDashboard> {
  @override
  void initState() {
    super.initState();
    if (Authenticate.isAutheticated() == false) {
      GoRouter.of(context).go('/');
    }
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Admin Dashboard'),
      body: SingleChildScrollView(
        primary: false,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(mainBg),
            ),
          ),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TravellerDashboardBody()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
