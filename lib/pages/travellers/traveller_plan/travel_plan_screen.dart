import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/pages/travellers/traveller_plan/traveller_plan_search.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class TravellerPlanScreen extends StatefulWidget {
  const TravellerPlanScreen({super.key});

  @override
  State<TravellerPlanScreen> createState() => _TravellerPlanScreenState();
}

class _TravellerPlanScreenState extends State<TravellerPlanScreen> {
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
                TravelPlanSearch()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
