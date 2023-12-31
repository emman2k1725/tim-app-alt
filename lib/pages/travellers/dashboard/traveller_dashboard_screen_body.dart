// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/homepage/cityGuide_page.dart';
import 'package:tim_app/pages/homepage/latestNews_page.dart';
import 'package:tim_app/pages/homepage/media_page.dart';
import 'package:tim_app/pages/homepage/specialOffers_page.dart';
import 'package:tim_app/pages/travellers/dashboard/traveller_carousel.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:tim_app/widgets/blurContainer.dart';
import 'package:tim_app/widgets/customButtons.dart';

import '../../../responsive.dart';
import '../../../utils/constants.dart';

class TravellerDashboardBody extends StatefulWidget {
  const TravellerDashboardBody({super.key});

  @override
  State<TravellerDashboardBody> createState() => _TravellerDashboardBodyState();
}

class _TravellerDashboardBodyState extends State<TravellerDashboardBody> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context) ? 0 : w / 20,
            vertical: 5),
        child: Responsive.isDesktop(context)
            ? DesktopScreenSize()
            : MobileScreenSize(),
      ),
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
    },
    {
      'icon': Icons.bookmark_add_rounded,
      'text': 'Latest News',
      'route': '/latest-news',
    },
    {
      'icon': Icons.maps_ugc_outlined,
      'text': 'City Guide',
      'route': '/city-guide',
    },
    {
      'icon': Icons.discount_outlined,
      'text': 'Special Offers',
      'route': '/special-offers',
    },
    {
      'icon': Icons.play_circle,
      'text': 'How it works',
      'route': '/how-it-works',
    },
  ];

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
                                        'Welcome Back!',
                                        style: AppTextstyle.headerTextStyle,
                                      ),
                                      const SizedBox(height: 15),
                                      const Text(
                                        'Embark on Adventure with Tim as Your Guide',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(height: 15),
                                      CustomButton(
                                          text: "Start the Magic",
                                          onPressed: () {}),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
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
                                      Icon(Icons.perm_media_outlined,
                                          color: Colors.lightBlueAccent),
                                      SizedBox(width: 5),
                                      Text(
                                        'Latest Media',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                CarouselImage()
                              ],
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
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
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          width: 150,
                                          padding: EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.blue, // Background color
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          child: Text(
                                            'Tim your Buddy!',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: const Text(
                                        'Exploring the World\'s Best Cuisines and Places',
                                        style: AppTextstyle.headerTextStyle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: const Text(
                                        'Journey with Tim to savor global cuisine and explore captivating places.',
                                        style: AppTextstyle.bodyTextStyle,
                                      ),
                                    ),
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
                                                'Explore Content',
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
                                                  onTap: () {
                                                    if (index == 0) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MediaPage()),
                                                      );
                                                    } else if (index == 1) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                LatestNewsPage()),
                                                      );
                                                    } else if (index == 2) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CityGuidePage()),
                                                      );
                                                    } else if (index == 3) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SpecialOffersPage()),
                                                      );
                                                    }
                                                  }),
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

class MobileScreenSize extends StatelessWidget {
  const MobileScreenSize({super.key});

  @override
  Widget build(BuildContext context) {
    List<double> weeklySummary = [
      4.40,
      2.50,
      42.42,
      10.50,
      80.20,
      89.20,
      90.10
    ];
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
        'route': '/latest-news',
      },
      {
        'icon': Icons.maps_ugc_outlined,
        'text': 'City Guide',
        'route': '/city-guide',
      },
      {
        'icon': Icons.discount_outlined,
        'text': 'Special Offers',
        'route': '/special-offers',
      },
      {
        'icon': Icons.play_circle,
        'text': 'How it works',
        'route': '/how-it-works',
      },
    ];

    return BlurContainer(
        // height: h!,
        // width: w!,
        childColumn: Padding(
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlurContainer(
              height: 220,
              width: double.maxFinite,
              childColumn: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: AppTextstyle.headerTextStyle,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Embark on Adventure with Tim as Your Guide',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  CustomButton(text: "Start the Magic", onPressed: () {}),
                ],
              ),
            ),
            SizedBox(height: 15),
            BlurContainer(
              //height: 220,
              width: double.maxFinite,
              childColumn: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.blue, // Background color
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Center(
                            child: Text(
                              'Tim your Buddy!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                        'Exploring the World\'s Best Cuisines and Places',
                        style: AppTextstyle.headerTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                        'Journey with Tim to savor global cuisine and explore captivating places.',
                        style: AppTextstyle.bodyTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            BlurContainer(
              //height: 220,
              width: double.maxFinite,
              childColumn: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.perm_media_outlined,
                              color: Colors.lightBlueAccent),
                          SizedBox(width: 5),
                          Text(
                            'Latest Media',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                        height: 220,
                        width: double.maxFinite,
                        child: CarouselImage()),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            BlurContainer(
              //height: 220,
              width: double.maxFinite,
              childColumn: Padding(
                padding: const EdgeInsets.all(15.0),
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
                                'Explore Content',
                                style: TextStyle(color: Colors.white),
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
                                  borderRadius: BorderRadius.circular(20)),
                              child: ListTile(
                                  leading: Icon(
                                    iconItems[index]['icon'],
                                    color: Colors.blueAccent,
                                  ),
                                  title: Text(
                                    iconItems[index]['text'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_right,
                                    size: 30,
                                    color: Colors.blueAccent,
                                  ),
                                  onTap: () {
                                    if (index == 0) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MediaPage()),
                                      );
                                    } else if (index == 1) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LatestNewsPage()),
                                      );
                                    } else if (index == 2) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CityGuidePage()),
                                      );
                                    } else if (index == 3) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SpecialOffersPage()),
                                      );
                                    }
                                  }),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
