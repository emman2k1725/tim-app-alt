import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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

  static List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 4, name: "Horse"),
    Animal(id: 5, name: "Tiger"),
    Animal(id: 6, name: "Penguin"),
    Animal(id: 7, name: "Spider"),
    Animal(id: 8, name: "Snake"),
    Animal(id: 9, name: "Bear"),
    Animal(id: 10, name: "Beaver"),
    Animal(id: 11, name: "Cat"),
    Animal(id: 12, name: "Fish"),
    Animal(id: 13, name: "Rabbit"),
    Animal(id: 14, name: "Mouse"),
    Animal(id: 15, name: "Dog"),
    Animal(id: 16, name: "Zebra"),
    Animal(id: 17, name: "Cow"),
    Animal(id: 18, name: "Frog"),
    Animal(id: 19, name: "Blue Jay"),
    Animal(id: 20, name: "Moose"),
    Animal(id: 21, name: "Gecko"),
    Animal(id: 22, name: "Kangaroo"),
    Animal(id: 23, name: "Shark"),
    Animal(id: 24, name: "Crocodile"),
    Animal(id: 25, name: "Owl"),
    Animal(id: 26, name: "Dragonfly"),
    Animal(id: 27, name: "Dolphin"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  //List<Animal> _selectedAnimals = [];
  List<Animal> _selectedAnimals2 = [];
  List<Animal> _selectedAnimals3 = [];
  //List<Animal> _selectedAnimals4 = [];
  List<Animal> _selectedAnimals5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();
  Future<List<String>>? _dropdownCruisines;
  @override
  void initState() {
    _selectedAnimals5 = _animals;
    super.initState();
  }

  List<String> selectedItems = [];

  void showMinimumSelectionError() {
    final snackBar = SnackBar(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(children: [
                          Container(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            height: 530,
                            child: MultiSelectDialogField(
                              chipDisplay: MultiSelectChipDisplay(
                                shape: const StadiumBorder(
                                    side: BorderSide(color: Colors.grey)),
                                textStyle: const TextStyle(
                                  fontSize:
                                      16, // Adjust the font size as needed
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                items: _items,
                                chipColor: Colors.blue,

                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(
                                      0.2), // Set the background color of the chips
                                  borderRadius: BorderRadius.circular(
                                      10), // Set the border radius of the chips
                                  border: Border.all(
                                      color: Colors.blue,
                                      width:
                                          2), // Set the border color and width of the chips
                                ),
                                onTap: (item) {
                                  // Handle chip tap event
                                },
                                chipWidth:
                                    100, // Adjust the width of the chips as needed
                                height:
                                    10, // Adjust the height of the chips as needed
                              ),

                              items: _items,
                              title: const Text("Cuisines"),
                              searchable: true,
                              // selectedColor: Colors.red,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              buttonIcon: const Icon(
                                Icons.fork_left_outlined,
                                color: Colors.blue,
                              ),
                              buttonText: Text(
                                "Favorite Cuisines",
                                style: TextStyle(
                                  color: Colors.blue[800],
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
                        ]),
                      ),
                      SizedBox(
                        height: 530,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          ),
                          child: Image.asset(
                            timHand,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      // Container(
                      //   decoration: const BoxDecoration(
                      //     borderRadius: BorderRadius.only(
                      //       topRight: Radius.circular(50.0),
                      //       bottomRight: Radius.circular(50.0),
                      //     ),
                      //   ),
                      //   height: 530,
                      //   child: Image.asset(
                      //     timHand,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                    ],
                  ),
                ))));
  }
}
