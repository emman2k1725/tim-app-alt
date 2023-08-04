import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/account/account_screen.dart';
import 'package:tim_app/pages/admin/manage_business/manage_business_screen.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class AdminAccountMain extends StatefulWidget {
  const AdminAccountMain({super.key});

  @override
  State<AdminAccountMain> createState() => _AdminAccountMainState();
}

class _AdminAccountMainState extends State<AdminAccountMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Custom AppBar'),
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
              children: [AdminAccountScreen()],
            ),
          ),
        ),
      ),
    );
  }
}
