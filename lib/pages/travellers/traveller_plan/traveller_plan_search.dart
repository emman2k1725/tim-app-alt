// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/backend/travel_plan/travelPlanFunction.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/pages/travellers/traveller_plan/components/travel_plan_date.dart';
import 'package:tim_app/pages/travellers/traveller_plan/travel_plan_kanban.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:tim_app/widgets/blurContainer.dart';
import 'package:tim_app/widgets/customButtons.dart';

import '../../../responsive.dart';

class TravelPlanSearch extends StatefulWidget {
  const TravelPlanSearch({super.key});

  @override
  State<TravelPlanSearch> createState() => _TravelPlanSearchState();
}

class _TravelPlanSearchState extends State<TravelPlanSearch> {
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
            //horizontal: Responsive.isDesktop(context) ? 0 : w / 20,
            vertical: 5),
        child: Responsive.isDesktop(context)
            ? DesktopScreenSize()
            : MobileScreenSize(),
      ),
    );
  }
}

class DesktopScreenSize extends StatefulWidget {
  const DesktopScreenSize({super.key});

  @override
  State<DesktopScreenSize> createState() => _DesktopScreenSizeState();
}

class _DesktopScreenSizeState extends State<DesktopScreenSize> {
  bool isLoading = false;
  final Map<String, dynamic> _travelPlanParameters = {};
  final _formKey = GlobalKey<FormState>();

  UserModel? user;
  @override
  void initState() {
    super.initState();
    loadNewLaunch();
  }

  loadNewLaunch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('user') != null) {
      setState(() {
        user = UserModel.fromMap(jsonDecode(pref.getString('user')!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlurContainer(
        //height: MediaQuery.sizeOf(context).,
        width: double.maxFinite,
        childColumn: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Start planning',
                        style: AppTextstyle.headerTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DateRangePickerTextField(
                              formKey: _formKey,
                              travelSearchParameters: _travelPlanParameters),
                        ]),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            child: SizedBox(
                              height: 300,
                              width: double.maxFinite,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Image.asset(
                                  homepageTim,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2.0),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Generating',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )
                      : BlueElevatedButton(
                          onPressed: () async {
                            bool flag = false;
                            if (isLoading) return;
                            setState(() {
                              isLoading = true;
                            });

                            if (_formKey.currentState!.validate() == true) {
                              _travelPlanParameters['startTime'] = [];
                              _travelPlanParameters['endTime'] = [];
                              _travelPlanParameters['dates'] = [];
                              _formKey.currentState!.save();

                              List<List<Map<String, dynamic>>> itenerary =
                                  await planTravel(user?.favCruisine,
                                      user?.favHangout, _travelPlanParameters);
                              _travelPlanParameters['userID'] = user?.docID;
                              setState(() {
                                isLoading = false;
                              });
                              for (int i = 0; i < itenerary.length; i++) {
                                if (itenerary[i].isEmpty) {
                                  setState(() {
                                    flag = true;
                                  });
                                  break;
                                }
                              }

                              if (flag == false) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TravelPlanKanban(
                                              travelitenerary: itenerary,
                                              traveliteneraryParameters:
                                                  _travelPlanParameters,
                                            )));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Unable to generate travel plan. Please select a different city or try again later.")));
                              }
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          text: 'Generate Plan',
                          iconData: Icons.generating_tokens_outlined,
                        ),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MobileScreenSize extends StatefulWidget {
  const MobileScreenSize({super.key});

  @override
  State<MobileScreenSize> createState() => _MobileScreenSizeState();
}

class _MobileScreenSizeState extends State<MobileScreenSize> {
  bool isLoading = false;
  bool flag = false;
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _travelPlanParameters = {
    "startDate": "",
    "endDate": "",
    "startTime": [],
    "endTime": [],
    "lat": "",
    "long": "",
    "days": "",
    "city": "",
    "dates": [],
    "userID": ""
  };
  UserModel? user;
  @override
  void initState() {
    super.initState();
    loadNewLaunch();
  }

  loadNewLaunch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('user') != null) {
      setState(() {
        user = UserModel.fromMap(jsonDecode(pref.getString('user')!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
        width: double.maxFinite,
        childColumn: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Start planning',
                    style: AppTextstyle.headerTextStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              DateRangePickerTextField(
                  formKey: _formKey,
                  travelSearchParameters: _travelPlanParameters),
              SizedBox(
                height: 20,
              ),
              isLoading
                  ? const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.0),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Generating',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  : BlueElevatedButton(
                      onPressed: () async {
                        if (isLoading) return;
                        setState(() {
                          isLoading = true;
                        });
                        await Future.delayed(const Duration(seconds: 1));
                        if (_formKey.currentState!.validate() == true) {
                          _formKey.currentState!.save();
                          List<List<Map<String, dynamic>>> itenerary =
                              await planTravel(user!.favCruisine,
                                  user?.favHangout, _travelPlanParameters);
                          _travelPlanParameters['userID'] = user?.docID;
                          setState(() {
                            isLoading = false;
                          });
                          if (itenerary.isNotEmpty) {
                            iteneraryToDatabase(
                                    itenerary, _travelPlanParameters)
                                .then((value) {
                              if (value == true) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TravelPlanKanban(
                                              travelitenerary: itenerary,
                                              traveliteneraryParameters:
                                                  _travelPlanParameters,
                                            )));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Unable to generate travel plan. Please select a different city or try again later.")));
                              }
                            });
                          }
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      text: 'Generate Plan',
                      iconData: Icons.generating_tokens_outlined,
                    ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
