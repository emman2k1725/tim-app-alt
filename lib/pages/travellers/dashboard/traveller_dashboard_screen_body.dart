import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/widgets/blurContainer.dart';

class TravellerDashboardBody extends StatefulWidget {
  const TravellerDashboardBody({super.key});

  @override
  State<TravellerDashboardBody> createState() => _TravellerDashboardBodyState();
}

class _TravellerDashboardBodyState extends State<TravellerDashboardBody> {
  @override
  Widget build(BuildContext context) {
    return const BlurContainer(
        height: 650,
        width: double.maxFinite,
        childColumn: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        BlurContainer(
                          height: 220,
                          width: double.maxFinite,
                          childColumn: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlurContainer(
                            height: 350,
                            width: double.maxFinite,
                            childColumn: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        BlurContainer(
                            height: 220,
                            width: double.maxFinite,
                            childColumn: Column()),
                        const SizedBox(
                          height: 20,
                        ),
                        BlurContainer(
                            height: 350,
                            width: double.maxFinite,
                            childColumn: Column()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
