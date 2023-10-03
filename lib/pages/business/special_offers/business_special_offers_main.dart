import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/pages/business/special_offers/business_offers_screen.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class BusinessSpecialOfferScreen extends StatefulWidget {
  const BusinessSpecialOfferScreen({super.key});

  @override
  State<BusinessSpecialOfferScreen> createState() =>
      _BusinessSpecialOfferScreenState();
}

class _BusinessSpecialOfferScreenState
    extends State<BusinessSpecialOfferScreen> {
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
    Color shadowColor = Colors.red;

    bool isApprove = true;
    return Scaffold(
      appBar: CustomAppBar(title: 'Custom AppBar'),
      body: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 1.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(mainBg),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
                child: isApprove == false
                    ? Text(
                        'YOUR ACCOUNT IS NOT YET APPROVE',
                        style: TextStyle(color: Colors.white),
                      )
                    : const BusinessOfferScreen())
          ],
        ),
      ),
    );
  }
}
