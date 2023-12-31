// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tim_app/pages/admin/dashboard/bar_graph/bar_graph.dart';
import 'package:tim_app/responsive.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:tim_app/widgets/blurContainer.dart';
import 'package:tim_app/widgets/customButtons.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? 0 : w! / 20, vertical: 5),
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

  List<double> weeklySummary = [4.40, 2.50, 42.42, 10.50, 80.20, 89.20, 90.10];
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 3',
  ];

  List<Map<String, dynamic>> iconItems = [
    {
      'icon': Icons.cameraswitch_outlined,
      'text': 'Media',
      'route': '/admin-manage-content/media',
    },
    {
      'icon': Icons.bookmark_add_rounded,
      'text': 'Latest News',
      'route': '/admin-manage-content/news',
    },
    {
      'icon': Icons.maps_ugc_outlined,
      'text': 'City Guide',
      'route': '/admin-manage-content/guide',
    },
    {
      'icon': Icons.discount_outlined,
      'text': 'Special Offers',
      'route': '/admin-manage-content/offer',
    },
    {
      'icon': Icons.play_circle,
      'text': 'How it works',
      'route': '/admin-manage-content/how',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 650,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
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

                border: Border.all(width: 2, color: Colors.white10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          BlurContainer(
                            height: 220,
                            width: double.maxFinite,
                            childColumn: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text(
                                          'Admin Magic',
                                          style: AppTextstyle.headerTextStyle,
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Enabling Smooth Business Approvals',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        const SizedBox(height: 15),
                                        CustomButton(
                                            text: "Start the Magic",
                                            onPressed: () {}),
                                      ],
                                    ),
                                    Container(
                                      height: 200,
                                      child: Image.network(
                                        homepageTim, // Replace this URL with your image URL

                                        fit: BoxFit
                                            .fill, // Set the image fit mode
                                      ),
                                    ),
                                  ],
                                )
                              ],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.numbers_outlined,
                                            color: Colors.lightBlueAccent),
                                        SizedBox(width: 5),
                                        Text(
                                          'No. of Users Visit',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: SizedBox(
                                        height: 220,
                                        width: double.maxFinite,
                                        child: BarGraph(
                                          weeklySummary: weeklySummary,
                                        )),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 220,
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
                                                    Icons
                                                        .account_circle_outlined,
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
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                '39',
                                                style: AppTextstyle
                                                    .headerTextStyle,
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
                                                style: AppTextstyle
                                                    .headerTextStyle,
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
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 350,
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
                                                Icon(Icons.content_copy_rounded,
                                                    color:
                                                        Colors.lightBlueAccent),
                                                SizedBox(width: 5),
                                                Text(
                                                  'Manage Content',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )),
                                      ),
                                      Container(
                                        height: 280,
                                        child: ListView.builder(
                                          itemCount: items.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.blue,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: ListTile(
                                                  leading: Icon(
                                                    iconItems[index]['icon'],
                                                    color: Colors.blueAccent,
                                                  ),
                                                  title: Text(
                                                    iconItems[index]['text'],
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  trailing: const Icon(
                                                    Icons.arrow_right,
                                                    size: 30,
                                                    color: Colors.blueAccent,
                                                  ),
                                                  onTap: () => context.go(
                                                    iconItems[index]['route'],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
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
      ),
    );
  }
}

class TabletScreenSize extends StatefulWidget {
  const TabletScreenSize({super.key});

  @override
  State<TabletScreenSize> createState() => _TabletScreenSizeState();
}

class _TabletScreenSizeState extends State<TabletScreenSize> {
  Color shadowColor = Colors.blueAccent;

  List<double> weeklySummary = [4.40, 2.50, 42.42, 10.50, 80.20, 89.20, 90.10];
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 3',
  ];

  List<Map<String, dynamic>> iconItems = [
    {
      'icon': Icons.cameraswitch_outlined,
      'text': 'Media',
    },
    {
      'icon': Icons.bookmark_add_rounded,
      'text': 'Latest News',
    },
    {
      'icon': Icons.maps_ugc_outlined,
      'text': 'City Guide',
    },
    {
      'icon': Icons.discount_outlined,
      'text': 'Special Offers',
    },
    {
      'icon': Icons.play_circle,
      'text': 'How it works',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 850,
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
                    flex: 6,
                    child: Column(
                      children: [
                        BlurContainer(
                          height: 190,
                          width: double.maxFinite,
                          childColumn: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        'Admin Magic',
                                        style: AppTextstyle.headerTextStyle,
                                      ),
                                      const SizedBox(height: 13),
                                      const Text(
                                        'Enabling Smooth Business Approvals',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(height: 13),
                                      CustomButton(
                                          text: "Start the Magic",
                                          onPressed: () {}),
                                    ],
                                  ),
                                  Container(
                                    height: 150,
                                    child: Image.network(
                                      homepageTim, // Replace this URL with your image URL

                                      fit:
                                          BoxFit.fill, // Set the image fit mode
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
                                      Icon(Icons.numbers_outlined,
                                          color: Colors.lightBlueAccent),
                                      SizedBox(width: 5),
                                      Text(
                                        'No. of Users Visit',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SizedBox(
                                      height: 220,
                                      width: double.maxFinite,
                                      child: BarGraph(
                                        weeklySummary: weeklySummary,
                                      )),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 190,
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
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
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
                                                  color: Colors.white,
                                                  fontSize: 13),
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
                                                  color: Colors.white,
                                                  fontSize: 13),
                                            ),
                                          ],
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
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 350,
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
                                              Icon(Icons.content_copy_rounded,
                                                  color:
                                                      Colors.lightBlueAccent),
                                              SizedBox(width: 5),
                                              Text(
                                                'Manage Content',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          )),
                                    ),
                                    Container(
                                      height: 280,
                                      child: ListView.builder(
                                        itemCount: items.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.blue,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: ListTile(
                                                leading: Icon(
                                                  iconItems[index]['icon'],
                                                  color: Colors.blueAccent,
                                                ),
                                                title: Text(
                                                  iconItems[index]['text'],
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                trailing: const Icon(
                                                  Icons.arrow_right,
                                                  size: 30,
                                                  color: Colors.blueAccent,
                                                ),
                                                onTap: () => context.go(
                                                  iconItems[index]['route'],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
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

class MobileScreenSize extends StatefulWidget {
  const MobileScreenSize({super.key});

  @override
  State<MobileScreenSize> createState() => _MobileScreenSizeState();
}

class _MobileScreenSizeState extends State<MobileScreenSize> {
  Color shadowColor = Colors.blueAccent;

  List<double> weeklySummary = [4.40, 2.50, 42.42, 10.50, 80.20, 89.20, 90.10];
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 3',
  ];

  List<Map<String, dynamic>> iconItems = [
    {
      'icon': Icons.cameraswitch_outlined,
      'text': 'Media',
    },
    {
      'icon': Icons.bookmark_add_rounded,
      'text': 'Latest News',
    },
    {
      'icon': Icons.maps_ugc_outlined,
      'text': 'City Guide',
    },
    {
      'icon': Icons.discount_outlined,
      'text': 'Special Offers',
    },
    {
      'icon': Icons.play_circle,
      'text': 'How it works',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 850,
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
                    height: 300,
                    width: double.maxFinite,
                    childColumn: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 120,
                                child: Image.network(
                                  homepageTim, // Replace this URL with your image URL

                                  fit: BoxFit.fill, // Set the image fit mode
                                ),
                              ),
                              SizedBox(height: 30),
                              const Text(
                                'Admin Magic',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Enabling Smooth Business Approvals',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 15),
                              CustomButton(
                                  text: "Start the Magic", onPressed: () {}),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: h,
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
                            border: Border.all(width: 2, color: Colors.white10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Icon(Icons.account_circle_outlined,
                                              color: Colors.lightBlueAccent),
                                          SizedBox(width: 5),
                                          Text(
                                            'Account',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13),
                                          ),
                                        ],
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '39',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Business',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '39',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'User',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25),
                                CustomButton(
                                    text: "Manage Account", onPressed: () {}),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                                Icon(Icons.numbers_outlined,
                                    color: Colors.lightBlueAccent),
                                SizedBox(width: 5),
                                Text(
                                  'No. of Users Visit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                                height: 220,
                                width: double.maxFinite,
                                child: BarGraph(
                                  weeklySummary: weeklySummary,
                                )),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: h,
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
                            border: Border.all(width: 2, color: Colors.white10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Icon(Icons.content_copy_rounded,
                                              color: Colors.lightBlueAccent),
                                          SizedBox(width: 5),
                                          Text(
                                            'Manage Content',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13),
                                          ),
                                        ],
                                      )),
                                ),
                                Container(
                                  height: 280,
                                  child: ListView.builder(
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.blue,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: ListTile(
                                            leading: Icon(
                                              iconItems[index]['icon'],
                                              color: Colors.blueAccent,
                                            ),
                                            title: Text(
                                              iconItems[index]['text'],
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            trailing: const Icon(
                                              Icons.arrow_right,
                                              size: 30,
                                              color: Colors.blueAccent,
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
