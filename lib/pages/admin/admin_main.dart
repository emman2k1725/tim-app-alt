import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/components/admin_screen.dart';
import 'package:tim_app/pages/admin/components/admin_sidemenu.dart';
import 'package:tim_app/pages/business/business_dashboard_main.dart';
import 'package:tim_app/pages/business/components/business_side_menu.dart';
import 'package:tim_app/utils/responsive.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BusinessSideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: AdminScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
