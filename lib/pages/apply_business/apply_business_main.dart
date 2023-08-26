import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/pages/apply_business/applyBusiness.dart';
import 'package:tim_app/utils/responsive.dart';

import '../../backend/firebase/userDataProvider.dart';
import '../dashboard_menu_components/side_menu.dart';

class ApplyBusinessMain extends StatelessWidget {
  const ApplyBusinessMain({super.key});

  @override
  Widget build(BuildContext context) {
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    if (userProvider.userData == null) {
      userProvider.loadDataFromSharedPref();
    }
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
              child: ApplyBusiness(),
            ),
          ],
        ),
      ),
    );
  }
}
