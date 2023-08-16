// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import 'package:tim_app/utils/colors.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:tim_app/widgets/blurContainer.dart';
import 'package:tim_app/widgets/customButtons.dart';


import '../../../responsive.dart';
import '../../../utils/constants.dart';


class ContentManagementScreen extends StatefulWidget {
  const ContentManagementScreen({super.key});

  @override
  State<ContentManagementScreen> createState() =>
      _ContentManagementScreenState();
}

class _ContentManagementScreenState extends State<ContentManagementScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? 0 : w / 20, vertical: 5),
      child: Responsive.isDesktop(context)
          ? DesktopScreenSize()
          : Responsive.isTablet(context)
              ? TabletScreenSize()
              : MobileScreenSize(),
    );
  }
}

class DesktopScreenSize extends StatefulWidget {
  const DesktopScreenSize({super.key});

  @override
  State<DesktopScreenSize> createState() => _DesktopScreenSizeState();
}

class _DesktopScreenSizeState extends State<DesktopScreenSize> {
  Color shadowColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 650,
      width: 950,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        BlurContainer(
                          height: 220,
                          width: double.maxFinite,
                          childColumn: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlurContainer(
                            height: 350,
                            width: double.maxFinite,
                            childColumn: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.source,
                                          color: Colors.lightBlueAccent),
                                      SizedBox(width: 5),
                                      Text(
                                        'Content',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          BlurContainer(
                                              height: 200,
                                              width: 170,
                                              childColumn: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.discount_outlined,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'Special Offers',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            AppColors.primary,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('View'),
                                                            Icon(Icons
                                                                .keyboard_arrow_right),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          BlurContainer(
                                              height: 200,
                                              width: 170,
                                              childColumn: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.ads_click_outlined,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'Advertisement',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            AppColors.primary,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('View'),
                                                            Icon(Icons
                                                                .keyboard_arrow_right),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          BlurContainer(
                                              height: 200,
                                              width: 170,
                                              childColumn: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.newspaper_outlined,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'Newsletter',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            AppColors.primary,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('View'),
                                                            Icon(Icons
                                                                .keyboard_arrow_right),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 590,
                          width: double.maxFinite,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    for (double i = 1; i < 5; i++)
                                      const BoxShadow(
                                        spreadRadius: -1,
                                        color: Colors.blueAccent,
                                        blurRadius: 1,
                                        blurStyle: BlurStyle.outer,
                                      )
                                  ],
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white60.withOpacity(0.10),
                                      Colors.blue.withOpacity(0.10),
                                    ],
                                  ),
                                  // color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      width: 2, color: Colors.white10),
                                ),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            children: [
                                              Icon(
                                                  Icons.account_circle_outlined,
                                                  color:
                                                      Colors.lightBlueAccent),
                                              SizedBox(width: 5),
                                              Text(
                                                'Account',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              '39',
                                              style:
                                                  AppTextstyle.headerTextStyle,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Business',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              '39',
                                              style:
                                                  AppTextstyle.headerTextStyle,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'User',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () => context.go(
                                                '/admin-manage-content/offer'),
                                            child: BlurImageContainer(
                                              height: 200,
                                              width: 200,
                                              text: 'Manage Special Offers',
                                              icon: Icons
                                                  .discount_outlined, // Replace with the desired icon
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 25),
                                    CustomButton(
                                        text: "Manage Account",
                                        onPressed: () {}),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

