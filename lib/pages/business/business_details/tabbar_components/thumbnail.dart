// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tim_app/utils/constants.dart';

import '../../../../responsive.dart';

class ImageRowPage extends StatelessWidget {
  final Map<String, dynamic> item;
  const ImageRowPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    String defaultImage = 'assets/images/empty-placeholder.png';
    String image1 = item['businessImages']['image1'] != null
        ? item['businessImages']['image1']
        : defaultImage;
    String image2 = item['businessImages']['image2'] != null
        ? item['businessImages']['image2']
        : defaultImage;
    String image3 = item['businessImages']['image3'] != null
        ? item['businessImages']['image3']
        : defaultImage;
    return Center(
      child:
          Responsive.isMobile(context) ? mobileContainer() : desktopContainer(),
    );
  }

  Widget desktopContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.network(
            'assets/images/sample1.jpg',
            fit: BoxFit.fill, // Set the fit option here
            width: 160,
            height: 130,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.network(
            'assets/images/sample2.jpg',
            fit: BoxFit.fill, // Set the fit option here
            width: 160,
            height: 130,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.network(
            'assets/images/sample3.jpg',
            fit: BoxFit.fill, // Set the fit option here
            width: 160,
            height: 130,
          ),
        ),
      ],
    );
  }

  Widget mobileContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              image1,
              fit: BoxFit.fill, // Set the fit option here
              width: 160,
              height: 130,
            ),
          ),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              image2,
              fit: BoxFit.fill, // Set the fit option here
              width: 160,
              height: 130,
            ),
          ),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              image3,
              fit: BoxFit.fill, // Set the fit option here
              width: 160,
              height: 130,
            ),
          ),
        ],
      ),
    );
  }
}
