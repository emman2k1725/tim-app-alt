import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/pages/business/business_details/business_details_tabbar.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class BusinessDetailsScreen extends StatefulWidget {
  const BusinessDetailsScreen({super.key});

  @override
  State<BusinessDetailsScreen> createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  UserModel? user;
  @override
  void initState() {
    loadNewLaunch();
    super.initState();
    if (Authenticate.isAutheticated() == false) {
      GoRouter.of(context).go('/');
    }
  }

  loadNewLaunch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('user') != null) {
      setState(() {
        user = UserModel.fromMap(jsonDecode(pref.getString('user')!));
      });
    }
    if (user?.hasBusiness == false) {
      GoRouter.of(context).go('/business');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Custom AppBar'),
      body: SingleChildScrollView(
        primary: false,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(mainBg),
            ),
          ),
          child: const SingleChildScrollView(
            child: Column(
              children: [BusinessTabBarView()],
            ),
          ),
        ),
      ),
    );
  }
}
