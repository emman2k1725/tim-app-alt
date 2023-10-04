import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/pages/business/advertisement/business_ads_screen.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class BusinessAdvertisementScreen extends StatefulWidget {
  const BusinessAdvertisementScreen({super.key});

  @override
  State<BusinessAdvertisementScreen> createState() =>
      _BusinessAdvertisementScreenState();
}

class _BusinessAdvertisementScreenState
    extends State<BusinessAdvertisementScreen> {
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
    bool isApprove = true;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Custom AppBar'),
      body: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 1.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(mainBg),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: isApprove == false
                      ? const Text(
                          'YOUR ACCOUNT IS NOT YET APPROVE',
                          style: TextStyle(color: Colors.white),
                        )
                      : const BusinessAdsScreen())
            ],
          ),
        ),
      ),
    );
  }
}
