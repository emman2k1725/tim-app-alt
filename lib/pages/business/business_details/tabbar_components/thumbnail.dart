// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tim_app/utils/constants.dart';

import '../../../../responsive.dart';

class ImageRowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              'assets/images/sample1.jpg',
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
              'assets/images/sample2.jpg',
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
              'assets/images/sample3.jpg',
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
