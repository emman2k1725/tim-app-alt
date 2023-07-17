import 'package:flutter/material.dart';
import 'package:tim_app/pages/containers/about_container1.dart';

import '../utils/constants.dart';
import '../widgets/navBar.dart';
import 'containers/container1.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(mainBg),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const NavBar(),
              const SizedBox(
                height: 20,
              ),
              const AboutContainer1(),
            ],
          ),
        ),
      ),
    );
  }
}
