import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/backend/firebase/UserDataProvider.dart';
import 'package:tim_app/pages/travellers/apply_business/applyBusiness.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class ApplyBusinessMain extends StatelessWidget {
  const ApplyBusinessMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Custom AppBar'),
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
              children: [ApplyBusiness()],
            ),
          ),
        ),
      ),
    );
  }
}