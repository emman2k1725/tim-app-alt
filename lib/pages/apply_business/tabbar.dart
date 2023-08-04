import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/profile/profile_edit.dart';
import 'package:tim_app/pages/profile/profile_interest.dart';
import 'package:tim_app/pages/profile/profile_personal_info.dart';

import '../../utils/constants.dart';

class MyTabBarView extends StatefulWidget {
  const MyTabBarView({super.key});

  @override
  _MyTabBarViewState createState() => _MyTabBarViewState();
}

class _MyTabBarViewState extends State<MyTabBarView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 3, vsync: this);
  }

  Color shadowColor = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
        height: 800,
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
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            labelPadding:
                                const EdgeInsets.only(left: 20, right: 20),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey,
                            tabs: const [
                              Tab(
                                text: "Personal Information",
                              ),
                              Tab(
                                text: "Interests",
                              )
                            ]),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        width: double.maxFinite,
                        height: 700,
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            UserProfileWidget(),
                            ProfileInterest(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
