import 'package:flutter/material.dart';
import 'package:tim_app/pages/apply_business/applyBusiness.dart';
import 'package:tim_app/utils/responsive.dart';

import '../dashboard_menu_components/side_menu.dart';

class ApplyBusinessMain extends StatelessWidget {
  const ApplyBusinessMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: context.read<MenuAppController>().scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: ApplyBusiness()),
          ],
        ),
      ),
    );
  }
}
