import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tim_app/pages/admin/content_management/components_special_offer/offer_listview.dart';
import 'package:tim_app/pages/admin/special_offers/offers_paginated.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:tim_app/widgets/blurContainer.dart';

class ContentManagementScreen extends StatefulWidget {
  const ContentManagementScreen({super.key});

  @override
  State<ContentManagementScreen> createState() =>
      _ContentManagementScreenState();
}

class _ContentManagementScreenState extends State<ContentManagementScreen> {
  Color shadowColor = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: 600,
              width: 680,
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
                      border: Border.all(width: 2, color: Colors.white10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: BlurContainer(
                            height: 200,
                            width: 630,
                            childColumn: Column(
                              children: [
                                Text('dsgah'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Manage Content',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () =>
                                      context.go('/admin-manage-content/offer'),
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
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () => context.go(
                                      '/admin-manage-content/advertisement'),
                                  child: BlurImageContainer(
                                    height: 200,
                                    width: 200,
                                    text: 'Manage Advertisement',
                                    icon: Icons
                                        .ads_click_outlined, // Replace with the desired icon
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () =>
                                      context.go('/admin-manage-content/news'),
                                  child: BlurImageContainer(
                                    height: 200,
                                    width: 200,
                                    text: 'Manage Newsletter',
                                    icon: Icons.newspaper_outlined,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: 600,
              width: 350,
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
                      border: Border.all(width: 2, color: Colors.white10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'More Content',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Container(height: 500, child: ListViewOfContainers()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
    // return Column(
    //   children: [
    //     Padding(
    //       padding: EdgeInsets.all(30.0),
    //       child: Row(
    //         children: [
    //           MouseRegion(
    //             cursor: SystemMouseCursors.click,
    //             child: GestureDetector(
    //               onTap: () => context.go('/admin-manage-content/offer'),
    //               child: BlurImageContainer(
    //                 height: 200,
    //                 width: 250,
    //                 text: 'Manage Special Offers',
    //                 icon: Icons
    //                     .discount_outlined, // Replace with the desired icon
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           MouseRegion(
    //             cursor: SystemMouseCursors.click,
    //             child: GestureDetector(
    //               onTap: () =>
    //                   context.go('/admin-manage-content/advertisement'),
    //               child: BlurImageContainer(
    //                 height: 200,
    //                 width: 250,
    //                 text: 'Manage Advertisement',
    //                 icon: Icons
    //                     .ads_click_outlined, // Replace with the desired icon
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           MouseRegion(
    //             cursor: SystemMouseCursors.click,
    //             child: GestureDetector(
    //               onTap: () => context.go('/admin-manage-content/news'),
    //               child: BlurImageContainer(
    //                 height: 200,
    //                 width: 250,
    //                 text: 'Manage Newsletter',
    //                 icon: Icons.newspaper_outlined,
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           BlurImageContainer(
    //             height: 200,
    //             width: 250,
    //             text: 'Manage Media',
    //             icon:
    //                 Icons.camera_alt_outlined, // Replace with the desired icon
    //           ),
    //         ],
    //       ),
    //     ),
    //     Container(height: 500, child: ListViewOfContainers()),
    //   ],
    // );
  }
}
