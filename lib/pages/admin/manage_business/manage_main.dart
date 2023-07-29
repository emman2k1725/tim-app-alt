import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/manage_business/manage_business_screen.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class ManageBusinessMain extends StatefulWidget {
  const ManageBusinessMain({super.key});

  @override
  State<ManageBusinessMain> createState() => _ManageBusinessMainState();
}

class _ManageBusinessMainState extends State<ManageBusinessMain> {
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
              children: [ManageBusinessScreen()],
            ),
          ),
        ),
      ),
    );
  }
}
