import 'package:flutter/material.dart';
import 'package:tim_app/pages/apply_business/tabbar.dart';

class ApplyBusiness extends StatefulWidget {
  const ApplyBusiness({super.key});

  @override
  State<ApplyBusiness> createState() => _ApplyBusinessState();
}

class _ApplyBusinessState extends State<ApplyBusiness>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 300,
      child: MyTabBarView(),
    );
  }
}
