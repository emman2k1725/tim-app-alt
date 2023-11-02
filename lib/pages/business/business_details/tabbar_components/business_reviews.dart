// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/reviews_components/reviews_list.dart';
import 'package:tim_app/responsive.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/blurContainer.dart';

class BusinessReview extends StatefulWidget {
  const BusinessReview({super.key});

  @override
  State<BusinessReview> createState() => _BusinessReviewState();
}

class _BusinessReviewState extends State<BusinessReview> {
  Color shadowColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
            //horizontal: Responsive.isDesktop(context) ? 0 : w / 20,
            vertical: 5),
        child: Responsive.isDesktop(context)
            ? DesktopScreenSize()
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: MobileScreenSize(),
              ),
      ),
    );
  }
}

class DesktopScreenSize extends StatelessWidget {
  const DesktopScreenSize({super.key});

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      width: double.maxFinite,
      height: h, //Responsive.isMobile(context) ? h : 230,

      childColumn: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Reviews', // Replace with your name or text
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Check travellers feedback', // Replace with your name or text
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Reviews', // Replace with your name or text
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '10.0k', // Replace with your name or text
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Growth in reviews this year', // Replace with your name or text
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  color: Colors.black,
                  thickness: 2,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Average Rating', // Replace with your name or text
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Text(
                          '4.5', // Replace with your name or text
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star_half_sharp,
                          color: Colors.yellow,
                        ),
                      ]),
                      Text(
                        'Travellers Rating', // Replace with your name or text
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Reviews', // Replace with your name or text
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '10.0k', // Replace with your name or text
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Growth in reviews this year', // Replace with your name or text
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            ReviewsList(),
          ],
        ),
      ),
    );
  }
}

class MobileScreenSize extends StatelessWidget {
  const MobileScreenSize({super.key});

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      childColumn: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Reviews', // Replace with your name or text
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'Check travellers feedback', // Replace with your name or text
              style: TextStyle(fontSize: 14.0, color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlurContainer(
                childColumn: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total Reviews', // Replace with your name or text
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '10.0k', // Replace with your name or text
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        'Growth in reviews this year', // Replace with your name or text
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(color: Colors.white),
                      ),
                      Text(
                        'Average Rating', // Replace with your name or text
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '4.5', // Replace with your name or text
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star_half_sharp,
                              color: Colors.yellow,
                            ),
                          ]),
                      Text(
                        'Travellers Rating', // Replace with your name or text
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(color: Colors.white),
                      ),
                      Text(
                        'Total Reviews', // Replace with your name or text
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '10.0k', // Replace with your name or text
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        'Growth in reviews this year', // Replace with your name or text
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ReviewsList(),
          ],
        ),
      ),
    );
  }
}
