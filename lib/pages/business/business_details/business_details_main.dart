import 'package:flutter/material.dart';
import 'package:tim_app/pages/business/business_details/business_details_screen.dart';
import 'package:tim_app/pages/business/components/business_side_menu.dart';
import 'package:tim_app/pages/dashboard_menu_components/side_menu.dart';
import 'package:tim_app/utils/responsive.dart';

class BusinessDetailsMain extends StatefulWidget {
  const BusinessDetailsMain({super.key});

  @override
  State<BusinessDetailsMain> createState() => _BusinessDetailsMainState();
}

class _BusinessDetailsMainState extends State<BusinessDetailsMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: context.read<MenuAppController>().scaffoldKey,
      drawer: const BusinessSideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: BusinessSideMenu(),
              ),
            const Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: BusinessDetailsScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
