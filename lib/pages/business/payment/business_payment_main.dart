import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/business/payment/business_payment.dart';
import 'package:tim_app/pages/business/special_offers/business_offers_screen.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class BusinessPaymentScreen extends StatelessWidget {
  const BusinessPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              Center(
                  child: isApprove == false
                      ? Text(
                          'YOUR ACCOUNT IS NOT YET APPROVE',
                          style: TextStyle(color: Colors.white),
                        )
                      : const BusinessPayment())
            ],
          ),
        ),
      ),
    );
  }
}
