import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/content_management/manage_city_guide/manage_cityGuide_screen.dart';
import 'package:tim_app/pages/admin/content_management/manage_media/manage_media_screen.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class ManageCityGuideScreenMain extends StatelessWidget {
  const ManageCityGuideScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
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
              Center(child: ManageCityGuideScreen())
            ],
          ),
        ),
      ),
    );
  }
}
