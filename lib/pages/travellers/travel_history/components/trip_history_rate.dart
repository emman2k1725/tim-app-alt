import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/backend/travel_plan/travelPlanFunction.dart';
import 'package:tim_app/pages/travellers/travel_history/components/trip_review_rate.dart';
import 'package:tim_app/responsive.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';
import 'package:tim_app/widgets/blurContainer.dart';

class TripHistoryRate extends StatefulWidget {
  final Map<String, dynamic> tripDetails;
  const TripHistoryRate({super.key, required this.tripDetails});

  @override
  State<TripHistoryRate> createState() => _TripHistoryRateState();
}

class _TripHistoryRateState extends State<TripHistoryRate> {
  Color shadowColor = Colors.blueAccent;
  @override
  void initState() {
    super.initState();
    if (Authenticate.isAutheticated() == false) {
      GoRouter.of(context).go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeNow = DateTime.now();
    List<Map<String, dynamic>> placesVisited = [];
    String formattedTime =
        "${timeNow.hour.toString().padLeft(2, '0')}:${timeNow.minute.toString().padLeft(2, '0')}";

    for (int y = 0; y < widget.tripDetails['itenerary'].length; y++) {
      // TRY TO COMBINE DATE AND TIME IN A SINGLE VARIABLE FIRST BEFORE COMPARING
      String date = widget.tripDetails['itenerary'][y]['dateSchedule'];
      String time = widget.tripDetails['itenerary'][y]['timeSchedule'];
      List<String> dateSplit = date.split('-');
      List<String> timeSplit = time.split(':');
      int year = int.parse(dateSplit[0]),
          month = int.parse(dateSplit[1]),
          day = int.parse(dateSplit[2]);
      int hour = 0, minute = 0;
      if (time.isNotEmpty) {
        hour = int.parse(timeSplit[0]);
        minute = int.parse(timeSplit[1]);
      }
      debugPrint(DateTime(year, month, day, hour, minute)
          .isBefore(DateTime.now())
          .toString());
      if ((DateTime(year, month, day, hour, minute).isBefore(DateTime.now()) ==
              true) &&
          widget.tripDetails['itenerary'][y]['source'] == 'local' &&
          widget.tripDetails['itenerary'][y]['ifRated'] == false) {
        placesVisited.add(widget.tripDetails['itenerary'][y]);
      }
    }
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
              height: 900,
              width: double.maxFinite,
              childColumn: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.maxFinite,
                      height: Responsive.isMobile(context) ? h : 750,
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
                              'Review', // Replace with your name or text
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Give feedback to recent trip', // Replace with your name or text
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Trip Details', // Replace with your name or text
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.tripDetails['day']
                                          .toString(), // Replace with your name or text
                                      style: const TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'days you went on a trip', // Replace with your name or text
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(
                                color: Colors.black,
                                thickness: 2,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Visited City', // Replace with your name or text
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(children: [
                                      Text(
                                        widget.tripDetails['city']
                                            .toString(), // Replace with your name or text
                                        style: const TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                                    const Text(
                                      'where you went', // Replace with your name or text
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Trip Date', // Replace with your name or text
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${widget.tripDetails['dates'][0]} - ${widget.tripDetails['dates'][widget.tripDetails['dates'].length - 1]}", // Replace with your name or text
                                      style: const TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'Date of your trip', // Replace with your name or text
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          HistoryReviewsList(
                            tripHistory: widget.tripDetails['itenerary'],
                            placeVisited: placesVisited,
                            fromDocID: widget.tripDetails['docID'],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
