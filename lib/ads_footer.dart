// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'pages/travellers/dashboard/traveller_carousel.dart';

class AdsFooter extends StatelessWidget {
  const AdsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
          padding: EdgeInsets.all(16.0),
          child: FooterCarousel(
              stream: FirebaseFirestore.instance
                  .collection('content')
                  .where("contentType", isEqualTo: 'Media')
                  .snapshots()),
        ),
      ],
    );
  }
}
