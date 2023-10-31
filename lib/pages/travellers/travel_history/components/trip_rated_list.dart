import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/reviews_components/reviews_list.dart';
import 'package:tim_app/responsive.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/blurContainer.dart';

class HistoryRated extends StatefulWidget {
  const HistoryRated({super.key});

  @override
  State<HistoryRated> createState() => _HistoryRatedState();
}

class _HistoryRatedState extends State<HistoryRated> {
  Color shadowColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      //width: double.maxFinite,
      childColumn: Padding(
        padding: EdgeInsets.all(Responsive.isMobile(context) ? 15.0 : 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Recent Rated', // Replace with your name or text
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Your feedback to your recent visited place', // Replace with your name or text
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              ReviewsList(),
            ],
          ),
        ),
      ),
    );
  }
}
