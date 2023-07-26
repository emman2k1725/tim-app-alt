// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../responsive.dart';
import '../../utils/appTheme_style.dart';
import '../../utils/constants.dart';
import '../../widgets/navBar.dart';

class SpecialOffersPage extends StatefulWidget {
  const SpecialOffersPage({super.key});

  @override
  State<SpecialOffersPage> createState() => _SpecialOffersPageState();
}

class _SpecialOffersPageState extends State<SpecialOffersPage> {
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
              NavBar(),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Responsive.isDesktop(context) ? w / 10 : w / 20,
                    vertical: 5),
                child: Responsive.isDesktop(context)
                    ? DesktopContainer1()
                    : Responsive.isTablet(context)
                        ? TabletContainer1()
                        : MobileContainer1(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DesktopContainer1 extends StatelessWidget {
  const DesktopContainer1({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.yellow,
      Colors.teal,
      Colors.pink,
      Colors.cyan,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Special Offer',
            style: AppTheme.getSecondaryTextStyle(50.0),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'PRICING AND TIMELINE',
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: w / 2,
          child: const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. Vestibulum porta libero quis mauris luctus, vel scelerisque ligula vulputate. Aliquam erat volutpat.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(height: 30),
        SingleChildScrollView(
          child: Column(
            children: List.generate((colors.length / 3).ceil(), (row) {
              return Row(
                children: List.generate(2, (index) {
                  final colorIndex = (row * 2) + index;
                  if (colorIndex < colors.length) {
                    return Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 15.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: h / 2.5,
                                color: colors[colorIndex],
                                child: Center(
                                  child: Text(
                                    "Offer Images",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: h / 2.5,
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. ",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: SizedBox(
                                          width: 250,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                'View',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Colors.black,
                                                      size: 15)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                        child: Container()); // Empty container for spacing
                  }
                }),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class TabletContainer1 extends StatelessWidget {
  const TabletContainer1({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.yellow,
      Colors.teal,
      Colors.pink,
      Colors.cyan,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Special Offer',
          style: AppTheme.getSecondaryTextStyle(50.0),
        ),
        SizedBox(height: 10),
        Text(
          'PRICING AND TIMELINE',
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: w / 1,
          child: const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. Vestibulum porta libero quis mauris luctus, vel scelerisque ligula vulputate. Aliquam erat volutpat.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(height: 30),
        ListView.separated(
          shrinkWrap: true,
          itemCount: colors.length,
          separatorBuilder: ((context, index) => SizedBox(height: 20)),
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: h / 2.5,
                    color: colors[index],
                    child: Center(
                      child: Text(
                        "Offer Images",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: h / 2.5,
                    color: Colors.white,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 250,
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. ",
                              textAlign: TextAlign.justify,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              width: 250,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'View',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.black,
                                          size: 15)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class MobileContainer1 extends StatelessWidget {
  const MobileContainer1({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.yellow,
      Colors.teal,
      Colors.pink,
      Colors.cyan,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Special Offer',
          style: AppTheme.getSecondaryTextStyle(30.0),
        ),
        SizedBox(height: 10),
        Text(
          'PRICING AND TIMELINE',
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: w / 1,
          child: const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. Vestibulum porta libero quis mauris luctus, vel scelerisque ligula vulputate. Aliquam erat volutpat.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(height: 30),
        ListView.separated(
          shrinkWrap: true,
          itemCount: colors.length,
          separatorBuilder: ((context, index) => SizedBox(height: 20)),
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    //width: 250,
                    height: h / 2.5,
                    color: colors[index],
                    child: Center(
                      child: Text(
                        "Offer Images",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    // width: 250,
                    height: h / 2.5,
                    color: Colors.white,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 250,
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. ",
                              textAlign: TextAlign.justify,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              width: 250,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'View',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.black,
                                          size: 15)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
