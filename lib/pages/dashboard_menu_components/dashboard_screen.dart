import 'package:flutter/material.dart';
import 'package:tim_app/pages/dashboard_menu_components/header.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/responsive.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
          child: Column(
            children: [
              Header(),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
