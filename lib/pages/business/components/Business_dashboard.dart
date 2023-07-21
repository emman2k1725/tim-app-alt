import 'package:flutter/material.dart';
import 'package:tim_app/pages/business/business_dashboard_main.dart';
import 'package:tim_app/pages/business/components/business_side_menu.dart';
import 'package:tim_app/utils/responsive.dart';

class BusinessMainScreen extends StatelessWidget {
  const BusinessMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BusinessSideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: BusinessSideMenu(),
              ),
            Expanded(
              flex: 5,
              child: BusinessScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
