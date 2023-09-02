// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tim_app/pages/travellers/traveller_plan/components/travel_plan_draggable.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:tim_app/widgets/appbar.dart';
import 'package:tim_app/widgets/blurContainer.dart';

class TravelPlanKanban extends StatefulWidget {
  const TravelPlanKanban({super.key});

  @override
  State<TravelPlanKanban> createState() => _TravelPlanKanbanState();
}

class _TravelPlanKanbanState extends State<TravelPlanKanban> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Admin Dashboard'),
      body: SingleChildScrollView(
        primary: false,
        child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(mainBg),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlurContainer(
                  height: 650,
                  width: double.maxFinite,
                  childColumn: Column(
                    children: [
                      Container(
                        height: 500,
                        width: double.maxFinite,
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
                            DraggableContainer(),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            )),
      ),
    );
  }
}
