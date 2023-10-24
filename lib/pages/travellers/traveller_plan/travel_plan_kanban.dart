// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tim_app/pages/travellers/traveller_plan/components/travel_plan_draggable.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:tim_app/widgets/appbar.dart';

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
        padding: EdgeInsets.all(8.0),
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
                    Container(
                      color: Colors
                          .transparent, // Set the background color for the footer
                      child: Center(
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButtonWithText(
                                  text: 'Save',
                                  iconData: Icons.save_alt,
                                  onPressed: () {
                                    // Add your onPressed callback logic here
                                    //   print('Button Pressed!');
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButtonWithText(
                                  text: 'Share',
                                  iconData: Icons.share,
                                  onPressed: () {
                                    // Add your onPressed callback logic here
                                    //   print('Button Pressed!');
                                  },
                                ),
                              ],
                            )),
                      ),
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

class IconButtonWithText extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onPressed;

  IconButtonWithText({
    required this.text,
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(iconData),
            SizedBox(width: 8), // Adjust the spacing between the icon and text
            Text(text),
          ],
        ),
      ),
    );
  }
}
