import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/backend/firebase/firebaseService.dart';
import 'package:tim_app/model/BusinessModel.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/pages/business/business_dashboard_body.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    loadNewLaunch();
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
    fetchBusinessData(user?.docID);
  }

  fetchBusinessData(String? userID) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    try {
      Map<String, dynamic> data = await fetchBusiness(userID!);
      BusinessModel businessData = BusinessModel.fromMapWithID(data);

      _pref.setString('business', jsonEncode(businessData.toMapWithID()));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  build(BuildContext context) {
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
          child: const SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                BusinessDashboardBody()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
