// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'pages/travellers/dashboard/traveller_carousel.dart';

class AdsFooter extends StatelessWidget {
  const AdsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black45,
        // gradient: LinearGradient(
        //   colors: [
        //     Color(0xFFEC6EAD),
        //     Color(0xFF3494E6),
        //   ],
        //   begin: Alignment.centerLeft,
        //   end: Alignment.centerRight,
        // ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.60,
                color: Color(0xFF3494E6),
                padding: EdgeInsets.all(16.0),
                child: Text('Leaderboard')
                // FooterCarousel(
                //     stream: FirebaseFirestore.instance
                //         .collection('content')
                //         .where("contentType", isEqualTo: 'Media')
                //         .snapshots()),
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Connect with us',
                  style: TextStyle(color: Colors.white),
                ),
                Row(
                  children: [
                    SocialIcon(
                      iconData: FontAwesomeIcons.facebook,
                      onPressed: () {
                        // Handle Facebook icon click
                        print('Facebook icon clicked');
                      },
                    ),
                    SocialIcon(
                      iconData: FontAwesomeIcons.instagram,
                      onPressed: () {
                        // Handle Twitter icon click
                        print('Twitter icon clicked');
                      },
                    ),
                    SocialIcon(
                      iconData: FontAwesomeIcons.tiktok,
                      onPressed: () {
                        // Handle Instagram icon click
                        print('Instagram icon clicked');
                      },
                    ),
                    SocialIcon(
                      iconData: FontAwesomeIcons.xTwitter,
                      onPressed: () {
                        // Handle Facebook icon click
                        print('Facebook icon clicked');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  SocialIcon({required this.iconData, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: FaIcon(
          iconData,
          color: Colors.white,
        ),
        // child: Icon(
        //   iconData,
        //   size: 40.0,
        //   color: Colors.blue, // You can customize the color
        // ),
      ),
    );
  }
}
