import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/backend/firebase/businessDataProvider.dart';
import 'package:tim_app/backend/firebase/firebaseService.dart';
import 'package:tim_app/pages/travellers/apply_business/tabbar.dart';
import 'package:tim_app/pages/dashboard_menu_components/header.dart';
import 'package:tim_app/utils/constants.dart';

import '../../backend/authservice/authentication.dart';
import '../../backend/firebase/UserDataProvider.dart';
import '../../model/BusinessModel.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  build(BuildContext context) {
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    if (userProvider.userData?.hasBusiness == false) {
      // back to traveller dashboard
    }
    BusinessDataProvider businessDataProvider =
        Provider.of<BusinessDataProvider>(context);
    bool isApprove = true;
    return SafeArea(
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
              SizedBox(
                height: 100,
              ),
              Center(
                child: isApprove == false
                    ? Text(
                        'YOUR ACCOUNT IS NOT YET APPROVE',
                        style: TextStyle(color: Colors.white),
                      )
                    : Text(
                        'YOUR ACCOUNT IS APPROVE',
                        style: TextStyle(color: Colors.white),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
