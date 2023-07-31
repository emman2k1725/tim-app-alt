import 'package:flutter/material.dart';
import 'package:tim_app/utils/constants.dart';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
