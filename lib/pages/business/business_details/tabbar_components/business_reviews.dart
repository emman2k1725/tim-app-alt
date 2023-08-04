import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/reviews_components/reviews_list.dart';
import 'package:tim_app/responsive.dart';
import 'package:tim_app/utils/constants.dart';

class BusinessReview extends StatefulWidget {
  const BusinessReview({super.key});

  @override
  State<BusinessReview> createState() => _BusinessReviewState();
}

class _BusinessReviewState extends State<BusinessReview> {
  Color shadowColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: Responsive.isMobile(context) ? h : 230,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
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
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '10.0k', // Replace with your name or text
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Growth in reviews this year', // Replace with your name or text
                      style: TextStyle(
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
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '10.0k', // Replace with your name or text
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Growth in reviews this year', // Replace with your name or text
                      style: TextStyle(
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
    );
  }
}
