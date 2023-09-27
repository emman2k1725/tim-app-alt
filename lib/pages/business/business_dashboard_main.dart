import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tim_app/pages/travellers/apply_business/tabbar.dart';
import 'package:tim_app/pages/dashboard_menu_components/header.dart';
import 'package:tim_app/utils/constants.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  build(BuildContext context) {
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
              const SizedBox(
                height: 100,
              ),
              Center(
                child: isApprove == false
                    ? const Text(
                        'YOUR ACCOUNT IS NOT YET APPROVE',
                        style: TextStyle(color: Colors.white),
                      )
                    : const Text(
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
