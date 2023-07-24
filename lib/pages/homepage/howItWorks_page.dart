// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../responsive.dart';
import '../../utils/appTheme_style.dart';
import '../../utils/constants.dart';
import '../../widgets/navBar.dart';
import '../containers/videoplayer.dart';

class HowItWorksPage extends StatefulWidget {
  const HowItWorksPage({super.key});

  @override
  State<HowItWorksPage> createState() => _HowItWorksPageState();
}

class _HowItWorksPageState extends State<HowItWorksPage> {
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

    List<String> dataList = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
      'Item 6',
      // Add more items as needed
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How It Works',
                style: AppTheme.getSecondaryTextStyle(50.0),
              ),
              SizedBox(height: 20),
              Text(
                'PRICING AND TIMELINE',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: w / 4,
                child: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. Vestibulum porta libero quis mauris luctus, vel scelerisque ligula vulputate. Aliquam erat volutpat.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 20),
              const Divider(
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 10.0, // Adjust spacing between containers horizontally
                runSpacing:
                    10.0, // Adjust spacing between containers vertically
                children: [
                  for (int i = 0; i < dataList.length; i += 2)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: h / 6,
                                width: w / 4,
                                padding: EdgeInsets.all(5.0),
                                color: Colors.grey.shade300,
                                child: Text(""),
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: w / 4,
                                padding: EdgeInsets.all(5.0),
                                color: Colors.grey.shade100,
                                child: Text(
                                  "Image\nGraphic Design",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        if (i + 1 < dataList.length)
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height: h / 6,
                                  width: w / 4,
                                  padding: EdgeInsets.all(5.0),
                                  color: Colors.grey.shade300,
                                  child: Text(""),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  width: w / 4,
                                  padding: EdgeInsets.all(5.0),
                                  color: Colors.grey.shade100,
                                  child: Text(
                                    "Image\nGraphic Design",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 100.0),
              child: SizedBox(height: 350, child: VideoPlayerScreen()),
            )),
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

    List<String> dataList = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
      'Item 6',
      // Add more items as needed
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w / 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 350, child: VideoPlayerScreen()),
          SizedBox(height: 30),
          Text(
            'How It Works',
            textAlign: TextAlign.center,
            style: AppTheme.getSecondaryTextStyle(30.0),
          ),
          SizedBox(height: 20),
          Text(
            'PRICING AND TIMELINE',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. Vestibulum porta libero quis mauris luctus, vel scelerisque ligula vulputate. Aliquam erat volutpat.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 20),
          const Divider(
            color: Colors.white,
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 10.0, // Adjust spacing between containers horizontally
            runSpacing: 10.0, // Adjust spacing between containers vertically
            children: [
              for (int i = 0; i < dataList.length; i += 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: h / 6,
                            width: w / 4,
                            padding: EdgeInsets.all(5.0),
                            color: Colors.grey.shade300,
                            child: Text(""),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: w / 4,
                            padding: EdgeInsets.all(5.0),
                            color: Colors.grey.shade100,
                            child: Text(
                              "Image\nGraphic Design",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    if (i + 1 < dataList.length)
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: h / 6,
                              width: w / 4,
                              padding: EdgeInsets.all(5.0),
                              color: Colors.grey.shade300,
                              child: Text(""),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: w / 4,
                              padding: EdgeInsets.all(5.0),
                              color: Colors.grey.shade100,
                              child: Text(
                                "Image\nGraphic Design",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class MobileContainer1 extends StatelessWidget {
  const MobileContainer1({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    List<String> dataList = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
      'Item 6',
      // Add more items as needed
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w / 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 350, child: VideoPlayerScreen()),
          SizedBox(height: 30),
          Text(
            'How It Works',
            textAlign: TextAlign.center,
            style: AppTheme.getSecondaryTextStyle(30.0),
          ),
          SizedBox(height: 20),
          Text(
            'PRICING AND TIMELINE',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. Vestibulum porta libero quis mauris luctus, vel scelerisque ligula vulputate. Aliquam erat volutpat.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 20),
          const Divider(
            color: Colors.white,
          ),
          SizedBox(height: 20),
          ListView.separated(
              shrinkWrap: true,
              itemCount: dataList.length,
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: h / 3,
                      width: w / 2,
                      padding: EdgeInsets.all(5.0),
                      color: Colors.grey.shade300,
                      child: Text(""),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: w / 2,
                      padding: EdgeInsets.all(5.0),
                      color: Colors.grey.shade100,
                      child: Text(
                        "Image\nGraphic Design",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                );
              })
          /*Wrap(
            spacing: 10.0, // Adjust spacing between containers horizontally
            runSpacing:
                double.infinity, // Adjust spacing between containers vertically
            children: [
              for (int i = 0; i < dataList.length; i++)
                Column(
                  children: [
                    Container(
                      height: h / 6,
                      width: w / 4,
                      padding: EdgeInsets.all(5.0),
                      color: Colors.grey.shade300,
                      child: Text(""),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: w / 4,
                      padding: EdgeInsets.all(5.0),
                      color: Colors.grey.shade100,
                      child: Text(
                        "Image\nGraphic Design",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
            ],
          ),*/
        ],
      ),
    );
  }
}
