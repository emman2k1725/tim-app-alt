// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tim_app/utils/constants.dart';

import '../../../../responsive.dart';

class ImageRowPage extends StatelessWidget {
  final Map<String, dynamic> item;
  const ImageRowPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    String image1 = item['businessImages']['image1'];
    String image2 = item['businessImages']['image2'];
    String image3 = item['businessImages']['image3'];
    return Center(
      child: Responsive.isMobile(context)
          ? mobileContainer(image1, image2, image3)
          : desktopContainer(image1, image2, image3),
    );
  }

  Widget desktopContainer(String image1, String image2, String image3) {
    String defaultImage = 'assets/images/empty-placeholder.png';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: item['businessImages']['image1'].toString() == ''
                ? Image.network(
                    defaultImage,
                    fit: BoxFit.fill, // Set the fit option here
                    width: 160,
                    height: 130,
                  )
                : Image.network(
                    image1,
                    fit: BoxFit.fill, // Set the fit option here
                    width: 160,
                    height: 130,
                  )),
        Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: item['businessImages']['image2'].toString() == ''
                ? Image.network(
                    defaultImage,
                    fit: BoxFit.fill, // Set the fit option here
                    width: 160,
                    height: 130,
                  )
                : Image.network(
                    image2,
                    fit: BoxFit.fill, // Set the fit option here
                    width: 160,
                    height: 130,
                  )),
        Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: item['businessImages']['image3'].toString() == ''
                ? Image.network(
                    defaultImage,
                    fit: BoxFit.fill, // Set the fit option here
                    width: 160,
                    height: 130,
                  )
                : Image.network(
                    image3,
                    fit: BoxFit.fill, // Set the fit option here
                    width: 160,
                    height: 130,
                  )),
      ],
    );
  }

  Widget mobileContainer(String image1, String image2, String image3) {
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
