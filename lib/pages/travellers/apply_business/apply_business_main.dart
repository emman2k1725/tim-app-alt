import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/pages/travellers/apply_business/apply_components/apply_main_screen.dart';
import 'package:tim_app/pages/travellers/apply_business/manage_components/manage_main_screen.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class ApplyBusinessMain extends StatefulWidget {
  const ApplyBusinessMain({super.key});

  @override
  State<ApplyBusinessMain> createState() => _ApplyBusinessMainState();
}

class _ApplyBusinessMainState extends State<ApplyBusinessMain> {
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
      body: SingleChildScrollView(
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                user?.hasBusiness == false
                    ? const ApplyMainScreen()
                    : const ManageApplyScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
