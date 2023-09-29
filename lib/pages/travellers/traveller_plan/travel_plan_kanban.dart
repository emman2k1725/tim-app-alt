// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
        height: MediaQuery.sizeOf(context).height * 1.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(mainBg),
          ),
        ),
        child: BlurContainer(
            width: double.maxFinite,
            height: 1500,
            childColumn: Column(
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
            )),
      ),
    );
  }
}
