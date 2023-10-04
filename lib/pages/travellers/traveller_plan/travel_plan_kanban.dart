// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/travellers/traveller_plan/components/travel_plan_draggable.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:tim_app/widgets/appbar.dart';
import 'package:tim_app/widgets/blurContainer.dart';

class TravelPlanKanban extends StatefulWidget {
  final List<List<Map<String, dynamic>>> travelitenerary;
  final Map<String, dynamic> traveliteneraryParameters;
  const TravelPlanKanban(
      {super.key,
      required this.travelitenerary,
      required this.traveliteneraryParameters});

  @override
  State<TravelPlanKanban> createState() => _TravelPlanKanbanState();
}

class _TravelPlanKanbanState extends State<TravelPlanKanban> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Admin Dashboard'),
      body: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(mainBg),
          ),
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 2),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.30),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8.0,
                      spreadRadius: 1,
                      offset: Offset(0, 8.0),
                    ),
                  ],

                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white60.withOpacity(0.10),
                      Colors.blue.withOpacity(0.10),
                    ],
                  ),
                  // color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.description_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'TIM Planning',
                            style: AppTextstyle.headerTextStyle,
                          )
                        ],
                      ),
                    ),
                    DraggableContainer(
                        travelitenerary: widget.travelitenerary,
                        traveliteneraryParameters:
                            widget.traveliteneraryParameters),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
