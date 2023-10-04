import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/pages/admin/content_management/admin_content_screen.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class ContentManagementMain extends StatefulWidget {
  const ContentManagementMain({super.key});

  @override
  State<ContentManagementMain> createState() => _ContentManagementMainState();
}

class _ContentManagementMainState extends State<ContentManagementMain> {
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
    if (user?.isAdmin == false) {
      GoRouter.of(context).go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color shadowColor = Colors.red;

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
        child: const SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(child: ContentManagementScreen())
            ],
          ),
        ),
      ),
    );
  }
}
