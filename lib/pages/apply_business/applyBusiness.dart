import 'package:flutter/material.dart';
import 'package:tim_app/pages/apply_business/tabbar.dart';
import 'package:tim_app/pages/dashboard_menu_components/header.dart';
import 'package:tim_app/utils/constants.dart';

class ApplyBusiness extends StatefulWidget {
  const ApplyBusiness({super.key});

  @override
  State<ApplyBusiness> createState() => _ApplyBusinessState();
}

class _ApplyBusinessState extends State<ApplyBusiness> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
          child: const Column(
            children: [
              Header(),
              SizedBox(
                height: 30,
              ),
              MyTabBarView(),
            ],
          ),
        ),
      ),
    );
  }
}
