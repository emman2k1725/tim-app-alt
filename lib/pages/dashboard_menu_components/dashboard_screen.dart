import 'package:flutter/material.dart';
import 'package:tim_app/pages/dashboard_menu_components/header.dart';
import 'package:tim_app/utils/responsive.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(10),
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
    );
  }
}
