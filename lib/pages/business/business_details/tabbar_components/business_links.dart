import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../responsive.dart';

class BusinessLinks extends StatelessWidget {
  const BusinessLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Responsive.isMobile(context) ? mobileContainer() : desktopContainer(),
    );
  }

  // Function to launch the Instagram profile link
  void launchInstagramProfile(String url) async {}

  Widget desktopContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              "/icons/facebook.svg", // Replace with the path to your SVG icon
              width: 30, // Set the desired width
              height: 20, // Set the desired height
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                launchInstagramProfile('https://johndoe.com/');
              },
              child: Text(
                ' https://johndoe.com/',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              "/icons/insta.svg", // Replace with the path to your SVG icon
              width: 30, // Set the desired width
              height: 20, // Set the desired height
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                launchInstagramProfile('https://johndoe.com/');
              },
              child: Text(
                ' https://johndoe.com/',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              "/icons/map.svg", // Replace with the path to your SVG icon
              width: 30, // Set the desired width
              height: 20, // Set the desired height
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                launchInstagramProfile('https://johndoe.com/');
              },
              child: Text(
                ' https://johndoe.com/',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget mobileContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              "/icons/facebook.svg", // Replace with the path to your SVG icon
              width: 30, // Set the desired width
              height: 20, // Set the desired height
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                launchInstagramProfile('https://johndoe.com/');
              },
              child: Text(
                ' https://johndoe.com/',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              "/icons/insta.svg", // Replace with the path to your SVG icon
              width: 30, // Set the desired width
              height: 20, // Set the desired height
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                launchInstagramProfile('https://johndoe.com/');
              },
              child: Text(
                ' https://johndoe.com/',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              "/icons/map.svg", // Replace with the path to your SVG icon
              width: 30, // Set the desired width
              height: 20, // Set the desired height
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                launchInstagramProfile('https://johndoe.com/');
              },
              child: Text(
                ' https://johndoe.com/',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
