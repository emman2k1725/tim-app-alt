import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/backend/firebase/fetchDropDown.dart';
import 'package:tim_app/utils/appTheme_style.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';

import '../../../backend/authservice/authentication.dart';
import '../../../backend/firebase/UserDataProvider.dart';
import '../../containers/multidropdown.dart';

class InterestSignup extends StatefulWidget {
  const InterestSignup({super.key});

  @override
  State<InterestSignup> createState() => _InterestSignupState();
}

class _InterestSignupState extends State<InterestSignup> {
  Color shadowColor = Colors.blueAccent;

  Future<List<String>>? _dropdownTravelCat;
  Future<List<String>>? _dropdownCruisines;
  Future<List<String>>? _dropdownInterests;
  Future<List<String>>? _dropdowncities;
  String? _selectedCat;

  @override
  void initState() {
    super.initState();
    _dropdownTravelCat = FirebaseService.fetchDropdownItems('travellerType');
    _dropdownCruisines = FirebaseService.fetchDropdownItems('cruisines');
    _dropdownInterests = FirebaseService.fetchDropdownItems('hangout');
    _dropdowncities = FirebaseService.fetchDropdownItems('cities');
  }

  List<String> selectedCruisines = [];
  List<String> selectedInterests = [];
  List<String> selectedCities = [];

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
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
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
                          FutureBuilder(
                              future: _dropdownCruisines,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }
                                List<String> fetchedItems = snapshot.data ?? [];
                                List<MultiSelectItem<String>>
                                    dropdownCruisineItems = fetchedItems
                                        .map((item) =>
                                            MultiSelectItem<String>(item, item))
                                        .toList();
                                return Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
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
                                        items: dropdownCruisineItems,
                                        chipDisplay: MultiSelectChipDisplay(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
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
                                              selectedCruisines =
                                                  values.cast<String>();
                                            });
                                          } else {
                                            showMinimumSelectionError();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          //start of favourite city
                          Expanded(
                            child: FutureBuilder(
                                future: _dropdowncities,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }
                                  List<String> fetchedItems =
                                      snapshot.data ?? [];
                                  List<MultiSelectItem<String>> dropdownCities =
                                      fetchedItems
                                          .map((item) =>
                                              MultiSelectItem<String>(
                                                  item, item))
                                          .toList();
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
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
                                        items: dropdownCities,
                                        chipDisplay: MultiSelectChipDisplay(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
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
                                              selectedCities =
                                                  values.cast<String>();
                                            });
                                          } else {
                                            showMinimumSelectionError();
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),

                      //Favorite Activity
                      FutureBuilder(
                          future: _dropdownInterests,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            List<String> fetchedItems = snapshot.data ?? [];
                            List<MultiSelectItem<String>> dropdownInterests =
                                fetchedItems
                                    .map((item) =>
                                        MultiSelectItem<String>(item, item))
                                    .toList();
                            return Padding(
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
                                  items: dropdownInterests,
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
                                    if (values.length >= 3 &&
                                        values.length <= 5) {
                                      setState(() {
                                        selectedInterests =
                                            values.cast<String>();
                                      });
                                    } else {
                                      showMinimumSelectionError();
                                    }
                                  },
                                ),
                              ),
                            );
                          }),
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
                      const SizedBox(height: 20),
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
                                onPressed: () async {
                                  if (validationCheck(
                                          selectedCruisines,
                                          selectedCities,
                                          selectedInterests,
                                          _selectedCat) ==
                                      true) {
                                    String result =
                                        await userProvider.updateUserInfo(
                                            authProvider.user!.uid,
                                            selectedCruisines,
                                            selectedInterests,
                                            selectedCities,
                                            _selectedCat);
                                    evaluateResult(result, context);
                                  } else {
                                    const snackBar = SnackBar(
                                      content: Text(
                                          'Please complete all fields required'),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
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

validationCheck(List<String> selectedCruisines, List<String> selectedCities,
    List<String> selectedInterests, String? category) {
  bool result = true;

  if (selectedCities.length < 3 || selectedCities.length > 5) {
    result = false;
  } else if (selectedCruisines.length < 3 || selectedCruisines.length > 5) {
    result = false;
  } else if (selectedInterests.length < 3 || selectedInterests.length > 5) {
    result = false;
  } else if (category == null) {
    result = false;
  }
  return result;
}

void evaluateResult(String result, BuildContext context) {
  if (result == 'success') {
    GoRouter.of(context).go('/dashboard');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ));
  }
}
