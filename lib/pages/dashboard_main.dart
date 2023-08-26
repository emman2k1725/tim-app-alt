import 'package:flutter/material.dart';
import 'package:tim_app/utils/responsive.dart';

import 'containers/multidropdown.dart';
import 'dashboard_menu_components/dashboard_screen.dart';
import 'dashboard_menu_components/side_menu.dart';

class DashboardMainScreen extends StatelessWidget {
  const DashboardMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),
            const Expanded(
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
