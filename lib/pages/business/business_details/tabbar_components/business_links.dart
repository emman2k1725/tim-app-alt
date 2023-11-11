import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../responsive.dart';

class BusinessLinks extends StatelessWidget {
  final Map<String, dynamic> item;
  const BusinessLinks({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Responsive.isMobile(context) ? mobileContainer() : desktopContainer(),
    );
  }

  // Function to launch the Instagram profile link
  void launchInstagramProfile(String url) async {}
  void launchFacebookProfile(String url) async {}
  void launchGoogleMap(String url) async {}

  Widget desktopContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width: 10),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              Uri url = Uri.parse(item['businessLinks']['facebook'].toString());
              var urllaunchable = await canLaunchUrl(url);
              if (urllaunchable) {
                await launchUrl(url);
              } else {
                print("URL can't be launched.");
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  "/icons/facebook.svg", // Replace with the path to your SVG icon
                  width: 30, // Set the desired width
                  height: 20, // Set the desired height
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                Text(
                  item['businessLinks']['facebook'].isNotEmpty
                      ? item['businessLinks']['facebook']
                      : ' No Facebook Link',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              Uri url =
                  Uri.parse(item['businessLinks']['instagram'].toString());
              var urllaunchable = await canLaunchUrl(url);
              if (urllaunchable) {
                await launchUrl(url);
              } else {
                print("URL can't be launched.");
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  "/icons/insta.svg",
                  width: 30,
                  height: 30,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                Text(
                  item['businessLinks']['instagram'].isNotEmpty
                      ? item['businessLinks']['instagram']
                      : ' No Instagram Link',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              Uri url =
                  Uri.parse(item['businessLinks']['googleMap'].toString());
              var urllaunchable = await canLaunchUrl(url);
              if (urllaunchable) {
                await launchUrl(url);
              } else {
                print("URL can't be launched.");
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  "/icons/map.svg",
                  width: 30,
                  height: 20,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                Text(
                  item['businessLinks']['googleMap'].isNotEmpty
                      ? item['businessLinks']['googleMap']
                      : ' No Google Map Link',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget mobileContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
                launchFacebookProfile(item['businessLinks']['facebook']);
              },
              child: Text(
                item['businessLinks']['facebook'],
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
                launchInstagramProfile(item['businessLinks']['instagram']);
              },
              child: Text(
                item['businessLinks']['instagram'],
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
                launchGoogleMap(item['businessLinks']['googleMap']);
              },
              child: Text(
                item['businessLinks']['googleMap'],
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
