// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/appbar.dart';
import '../../widgets/blurContainer.dart';

class AdminMorePage extends StatefulWidget {
  const AdminMorePage({super.key});

  @override
  State<AdminMorePage> createState() => _AdminMorePageState();
}

class _AdminMorePageState extends State<AdminMorePage> {
  @override
  Widget build(BuildContext context) {
    Color shadowColor = Colors.blueAccent;

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
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: SizedBox(
                  // height: h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            for (double i = 1; i < 5; i++)
                              BoxShadow(
                                spreadRadius: -1,
                                color: shadowColor,
                                blurRadius: 1,
                                blurStyle: BlurStyle.outer,
                              )
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white60.withOpacity(0.10),
                                Colors.blue.withOpacity(0.10)
                              ]),
                          // color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(width: 2, color: Colors.white10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              BlurContainer(
                                  height: 100,
                                  width: MediaQuery.sizeOf(context).width,
                                  childColumn: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset("/icons/business.svg",
                                          colorFilter: ColorFilter.mode(
                                              Colors.white, BlendMode.srcIn)),
                                      SizedBox(height: 10),
                                      Text(
                                        'Content Management',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              BlurContainer(
                                  height: 100,
                                  width: MediaQuery.sizeOf(context).width,
                                  childColumn: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset("/icons/business.svg",
                                          colorFilter: ColorFilter.mode(
                                              Colors.white, BlendMode.srcIn)),
                                      SizedBox(height: 10),
                                      Text(
                                        'Account',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              BlurContainer(
                                  height: 100,
                                  width: MediaQuery.sizeOf(context).width,
                                  childColumn: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset("/icons/logout.svg",
                                          colorFilter: ColorFilter.mode(
                                              Colors.white, BlendMode.srcIn)),
                                      SizedBox(height: 10),
                                      Text(
                                        'Logout',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              /*Center(
                  child: isApprove == false
                      ? Text(
                          'YOUR ACCOUNT IS NOT YET APPROVE',
                          style: TextStyle(color: Colors.white),
                        )
                      : const ContentManagementScreen())*/
            ],
          ),
        ),
      ),
    );
  }
}
