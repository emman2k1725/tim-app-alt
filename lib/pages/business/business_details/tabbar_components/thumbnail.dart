// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tim_app/utils/constants.dart';

import '../../../../responsive.dart';

class ImageRowPage extends StatelessWidget {
  final Map<String, dynamic> item;
  const ImageRowPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    String image1 = item['businessImages']['image1'] ?? '';
    String image2 = item['businessImages']['image2'] ?? '';
    String image3 = item['businessImages']['image3'] ?? '';
    return Center(
      child: Responsive.isMobile(context)
          ? mobileContainer(image1, image2, image3)
          : desktopContainer(image1, image2, image3),
    );
  }

  Widget desktopContainer(String image1, String image2, String image3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: image1.isNotEmpty
              ? Image.network(
                  image1,
                  width: 160, // Adjust the width as needed
                  height: 130, // Adjust the height as needed
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image,
                      size: 160,
                      color: Colors.white, // Customize the color
                    );
                  },
                )
              : Icon(
                  Icons.image,
                  size: 160,
                  color: Colors.white, // Customize the color
                ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: image2.isNotEmpty
              ? Image.network(
                  image2,
                  width: 160, // Adjust the width as needed
                  height: 130, // Adjust the height as needed
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image,
                      size: 160,
                      color: Colors.white, // Customize the color
                    );
                  },
                )
              : Icon(
                  Icons.image,
                  size: 160,
                  color: Colors.white, // Customize the color
                ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: image3.isNotEmpty
              ? Image.network(
                  image3,
                  width: 160, // Adjust the width as needed
                  height: 130, // Adjust the height as needed
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image,
                      size: 160,
                      color: Colors.white, // Customize the color
                    );
                  },
                )
              : Icon(
                  Icons.image,
                  size: 160,
                  color: Colors.white, // Customize the color
                ),
        ),
        SizedBox(
          height: 10,
        )
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
