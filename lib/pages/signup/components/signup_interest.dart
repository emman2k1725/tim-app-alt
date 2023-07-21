import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:tim_app/backend/firebase/fetchDropDown.dart';
import 'package:tim_app/utils/appTheme_style.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';

import '../../containers/multidropdown.dart';

class InterestSignup extends StatefulWidget {
  const InterestSignup({super.key});

  @override
  State<InterestSignup> createState() => _InterestSignupState();
}

class _InterestSignupState extends State<InterestSignup> {
  Color shadowColor = Colors.blueAccent;

  static final List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 4, name: "Horse"),
    Animal(id: 5, name: "Tiger"),
    Animal(id: 6, name: "Penguin"),
    Animal(id: 7, name: "Spider"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();

  Future<List<String>>? _dropdownTravelCat;

  String? _selectedCat;

  @override
  void initState() {
    super.initState();
    _dropdownTravelCat = FirebaseService.fetchDropdownItems('travellerType');
  }

  List<String> selectedItems = [];

  void showMinimumSelectionError() {
    const snackBar = SnackBar(
      content: Text('Please select at least 3 items and a minimum of 5 items.'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 550,
        margin: EdgeInsets.symmetric(horizontal: w! / 10, vertical: 20),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  // width: 300,
                  decoration: BoxDecoration(
                    boxShadow: [
                      for (double i = 1; i < 5; i++)
                        BoxShadow(
                          spreadRadius: -1,
                          color: shadowColor,
                          blurRadius: 1,
                          blurStyle: BlurStyle.outer,
                        )
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white60.withOpacity(0.10),
                          Colors.blue.withOpacity(0.10)
                        ]),
                    // color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 2, color: Colors.white10),
                  ),

                  child: SingleChildScrollView(
                    child: Column(children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                        child: Center(
                          child: Text(
                            'INTERESTS',
                            style: AppTheme.getSecondaryTextStyle(25),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                        child: Center(
                          child: Text(
                            'Share your interests with us, and TIM will create an extraordinary travel itinerary tailored to your adventure.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              letterSpacing: 1.5,
                              wordSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      //start of cuisines
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: MultiSelectDialogField(
                                  items: _items,
                                  chipDisplay: MultiSelectChipDisplay(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    chipColor: Colors.blue,
                                  ),
                                  title: const Text("Cuisines"),
                                  searchable: true,
                                  buttonIcon: const Icon(
                                    Icons.restaurant_outlined,
                                    color: Colors.blue,
                                  ),
                                  buttonText: const Text(
                                    "Favorite Cuisines",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  onConfirm: (values) {
                                    if (values.length >= 3 &&
                                        values.length <= 5) {
                                      setState(() {
                                        selectedItems = values.cast<String>();
                                      });
                                    } else {
                                      showMinimumSelectionError();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          //start of favourite city
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: MultiSelectDialogField(
                                  items: _items,
                                  chipDisplay: MultiSelectChipDisplay(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    chipColor: Colors.blue,
                                  ),
                                  title: const Text("Cities"),
                                  searchable: true,
                                  buttonIcon: const Icon(
                                    Icons.location_city_outlined,
                                    color: Colors.blue,
                                  ),
                                  buttonText: const Text(
                                    "Top 5 Cities",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  onConfirm: (values) {
                                    if (values.length >= 3 &&
                                        values.length <= 5) {
                                      setState(() {
                                        selectedItems = values.cast<String>();
                                      });
                                    } else {
                                      showMinimumSelectionError();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      //Favorite Activity
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10, 10, 10, 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: MultiSelectDialogField(
                            items: _items,
                            chipDisplay: MultiSelectChipDisplay(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              chipColor: Colors.blue,
                            ),
                            title: const Text("Activities"),
                            searchable: true,
                            buttonIcon: const Icon(
                              Icons.restaurant_outlined,
                              color: Colors.blue,
                            ),
                            buttonText: const Text(
                              "Favorite Activities",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            onConfirm: (values) {
                              if (values.length >= 3 && values.length <= 5) {
                                setState(() {
                                  selectedItems = values.cast<String>();
                                });
                              } else {
                                showMinimumSelectionError();
                              }
                            },
                          ),
                        ),
                      ),
                      //category

                      Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 10, 10, 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: Colors.blue,
                                width: 2,
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                const SizedBox(height: 16.0),
                                const Text(
                                  'Travel Category',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                FutureBuilder<List<String>>(
                                  future: _dropdownTravelCat,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }

                                    final dropdownItems = snapshot.data ?? [];

                                    return DropdownButton<String>(
                                      value: _selectedCat,
                                      items: dropdownItems.map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedCat = value;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          )),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                style: elevatedButtonStyle,
                                onPressed: () {
                                  //   GoRouter.of(context).go('/das');
                                },
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                ))));
  }
}
