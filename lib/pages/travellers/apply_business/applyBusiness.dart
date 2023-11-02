import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/backend/firebase/UserDataProvider.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

import 'components/stepper_business.dart';

class ApplyBusiness extends StatefulWidget {
  const ApplyBusiness({super.key});

  @override
  State<ApplyBusiness> createState() => _ApplyBusinessState();
}

class _ApplyBusinessState extends State<ApplyBusiness> {
  Color shadowColor = Colors.blueAccent;
  UserModel? user;
  @override
  void initState() {
    super.initState();
    if (Authenticate.isAutheticated() == false) {
      GoRouter.of(context).go('/');
    }
    loadNewLaunch();
  }

  loadNewLaunch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('user') != null) {
      setState(() {
        user = UserModel.fromMap(jsonDecode(pref.getString('user')!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Admin Dashboard'),
      body: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 1.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(mainBg),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SizedBox(
            height: 800,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      for (double i = 1; i < 5; i++)
                        BoxShadow(
                          spreadRadius: -1,
                          color: shadowColor,
                          blurRadius: 1,
                          blurStyle: BlurStyle.outer,
                        )
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white60.withOpacity(0.10),
                          Colors.blue.withOpacity(0.10)
                        ]),
                    // color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 2, color: Colors.white10),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: StepperWidget(userProvider: user)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
