import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/content_management/manage_news/manage_news_screen.dart';
import 'package:tim_app/pages/business/advertisement/business_ads_screen.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class ManageNewsScreenMain extends StatelessWidget {
  const ManageNewsScreenMain({super.key});

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(child: const ManageNewsScreen())
            ],
          ),
        ),
      ),
    );
  }
}
