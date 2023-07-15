// Automatic FlutterFlow imports
import 'dart:js_interop';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:tim_app/backend/firebase/fetchDropDown.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!
import 'package:tim_app/backend/authservice/createUserProfile.dart';
import 'package:tim_app/data/cuisine_data.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _StepperWidgetState createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  // List<bool> isSelected = [false, false, false]; // Track the selected state of buttons
  List<String> buttonLabels = ['Option 1', 'Option 2'];
  List<bool> isSelected = [false, false]; // Track the selected state of buttons

  //Date picker
  TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  String? _selectedValue;
  Future<List<String>>? _dropdownCruisines;
  Future<List<String>>? _dropdownHangouts;
  Future<List<String>>? _dropdownTravelCat;

  //Editding COntroller
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  final controllerCuisine = TextEditingController();
  final controllerHangout = TextEditingController();
  String selectedOption = 'Budget';
  List<String> options = ['Business', 'Leisure', 'Family Group', 'Budget'];

  void initState() {
    super.initState();
    _dropdownCruisines = FirebaseService.fetchDropdownItems('cruisines');
    _dropdownHangouts = FirebaseService.fetchDropdownItems('hangout');
    _dropdownTravelCat = FirebaseService.fetchDropdownItems('travellerType');
  }

  //city picker value
  String? country = "";
  String? state = "";
  String? city = "";
  String? building = "";
  String? street = "";
  String? postal = "";
  String? cruisine = "";
  String? hangout = "";
  String? travellerCat = "";

  int currentStep = 0;

  String? _validateToggleSelection(List<bool> selections) {
    if (selectedGender != null) {
      return null; // Valid selection
    } else {
      return 'Please select your gender'; // Invalid selection
    }
  }

//Gender toggle
  List<String> _genderChoice = <String>['Male', 'Female'];
  List<bool> _selections = [false, false];
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 600,
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                  elevation: 0, //Horizontal Impact
                  type: StepperType.horizontal,
                  physics: const ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                      title: const Text('Personal Information'),
                      content: Container(
                        color:
                            Colors.white, // Set the background color of Step 1
                        child: Column(
                          children: [
                            const Text(
                              'Birthdate',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: _dateController,
                              readOnly: true,
                              onTap: () => _selectDate(context),
                              decoration: InputDecoration(
                                labelText: 'Date of Birth',
                                prefixIcon: const Icon(Icons.calendar_today),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Set the border radius
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your birthdate";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Gender',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                ToggleButtons(
                                  isSelected: _selections,
                                  onPressed: (index) {
                                    setState(() {
                                      _selections[index] = !_selections[index];
                                      // Update the selected state of buttons
                                      for (int buttonIndex = 0;
                                          buttonIndex < _selections.length;
                                          buttonIndex++) {
                                        _selections[buttonIndex] =
                                            (buttonIndex == index);
                                      }
                                      selectedGender = _selections[index]
                                          ? _genderChoice[index]
                                          : '';
                                    });
                                  },
                                  constraints: const BoxConstraints(
                                    minHeight: 40.0,
                                    minWidth: 80.0,
                                  ),
                                  selectedColor: Colors.white,
                                  fillColor: Colors
                                      .blue, // Set the background color when a button is selected
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderColor: Colors.blue,
                                  children: _genderChoice.map((String value) {
                                    return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(value));
                                  }).toList(),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  _validateToggleSelection(_selections) ?? '',
                                  style: TextStyle(color: Colors.red),
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  'Address',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Building Address',
                                    hintText: 'Room No./Bldg. No. ',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Set the border radius
                                    ),
                                  ),
                                  onSaved: (value) {
                                    building = value;
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Street Address',
                                    hintText: 'Blk. No./Str No.',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Set the border radius
                                    ),
                                  ),
                                  onSaved: (value) {
                                    street = value;
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'State',
                                      hintText: 'State/Province/Region',
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blue),
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Set the border radius
                                      ),
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your State/Province/Region";
                                      } else {
                                        state = value;
                                        return null;
                                      }
                                    }),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'City',
                                      hintText: 'City/Municipality/Town',
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blue),
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Set the border radius
                                      ),
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your City/Municipality/Town";
                                      } else {
                                        city = value;
                                        return null;
                                      }
                                    }),
                                const SizedBox(height: 10.0),
                                TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Postal code',
                                      hintText: 'Postal Code',
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blue),
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Set the border radius
                                      ),
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your Postal code";
                                      } else {
                                        postal = value;
                                        return null;
                                      }
                                    }),
                                const SizedBox(height: 10.0),
                                TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Country',
                                      hintText: 'Country',
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blue),
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Set the border radius
                                      ),
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your Country";
                                      } else {
                                        country = value;
                                        return null;
                                      }
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: const Text('Interest'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Favorite Cuisine',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16.0),
                          //dropdown
                          buildCuisine(),
                          const SizedBox(height: 16.0),
                          const Text(
                            'Favorite Hangout Place',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16.0),
                          buildHangout(),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: const Text('Other Information'),
                      content: Column(
                        children: <Widget>[
                          const SizedBox(height: 16.0),
                          const Text(
                            'Travel Category',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          FutureBuilder<List<String>>(
                            future: _dropdownTravelCat,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }

                              final dropdownItems = snapshot.data ?? [];

                              return DropdownButton<String>(
                                value: _selectedValue,
                                items: dropdownItems.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue = value;
                                    travellerCat = _selectedValue;
                                  });
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                  controlsBuilder:
                      (BuildContext context, ControlsDetails controls) {
                    if (_currentStep >= 2) {
                      return Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Validation successful, perform the desired action
                                debugPrint('Good to go');
                              }
                            },
                            child: Text('Submit'),
                          ),
                          SizedBox(width: 16.0),
                          TextButton(
                            onPressed: cancel,
                            child: Text('Back'),
                          ),
                        ],
                      );
                    } else {
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: continued,
                                child: const Text('NEXT'),
                              ),
                              if (_currentStep != 0)
                                TextButton(
                                  onPressed: cancel,
                                  child: const Text(
                                    'BACK',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                            ],
                          ));
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCuisine() => FutureBuilder<List<String>>(
        future: _dropdownCruisines,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final dropdownItems = snapshot.data ?? [];

          return TypeAheadFormField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: controllerCuisine,
              decoration: InputDecoration(
                labelText: 'Select an option',
              ),
            ),
            suggestionsCallback: (pattern) async {
              final lowercasePattern = pattern.toLowerCase();
              return dropdownItems
                  .where(
                      (item) => item.toLowerCase().contains(lowercasePattern))
                  .toList();
            },
            itemBuilder: (context, String suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            onSuggestionSelected: (String suggestion) {
              setState(() {
                _selectedValue = suggestion;
                controllerCuisine.text = _selectedValue!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your favorite cruisine';
              }
              return null;
            },
            onSaved: (value) {
              cruisine = value;
            },
          );
        },
      );
  Widget buildHangout() => FutureBuilder<List<String>>(
        future: _dropdownHangouts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final dropdownItems = snapshot.data ?? [];

          return TypeAheadFormField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: controllerHangout,
              decoration: InputDecoration(
                labelText: 'Select an option',
              ),
            ),
            suggestionsCallback: (pattern) async {
              final lowercasePattern = pattern.toLowerCase();
              return dropdownItems
                  .where(
                      (item) => item.toLowerCase().contains(lowercasePattern))
                  .toList();
            },
            itemBuilder: (context, String suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            onSuggestionSelected: (String suggestion) {
              controllerHangout.text = suggestion;
              setState(() {
                _selectedValue = suggestion;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your favorite hangout place';
              }
              return null;
            },
            onSaved: (value) {
              hangout = value;
            },
          );
        },
      );

// Stepper numbering
  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      _currentStep < 2 ? setState(() => _currentStep += 1) : null;
    }
    debugPrint(selectedGender);
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
