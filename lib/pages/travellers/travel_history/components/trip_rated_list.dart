import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/reviews_components/reviews_list.dart';
import 'package:tim_app/responsive.dart';
import 'package:tim_app/utils/constants.dart';

class HistoryRated extends StatefulWidget {
  const HistoryRated({super.key});

  @override
  State<HistoryRated> createState() => _HistoryRatedState();
}

class _HistoryRatedState extends State<HistoryRated> {
  Color shadowColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: Responsive.isMobile(context) ? h : 230,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
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
                  color: Colors.blueAccent),
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Your feedback to your recent visited place', // Replace with your name or text
              style: TextStyle(
                fontSize: 14.0,
              ),
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
    );
  }
}
