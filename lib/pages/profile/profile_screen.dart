import 'package:flutter/material.dart';
import 'package:tim_app/pages/apply_business/tabbar.dart';
import 'package:tim_app/utils/constants.dart';

import '../dashboard_menu_components/header.dart';
import '../signup/signup_completion.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          child: const SingleChildScrollView(
            child: Column(
              children: [Header(), MyTabBarView()],
            ),
          ),
        ),
      ),
    );
  }
}
