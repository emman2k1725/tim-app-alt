// Automatic FlutterFlow imports
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

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

  //Editding COntroller
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  final controllerCuisine = TextEditingController();
  final controllerHangout = TextEditingController();

  String selectedOption = 'Budget';
  List<String> options = ['Business', 'Leisure', 'Family Group', 'Budget'];

  //city picker value
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  int currentStep = 0;

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
                            const SizedBox(height: 16.0),
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
                                  isSelected: isSelected,
                                  onPressed: (index) {
                                    setState(() {
                                      // Update the selected state of buttons
                                      for (int buttonIndex = 0;
                                          buttonIndex < isSelected.length;
                                          buttonIndex++) {
                                        isSelected[buttonIndex] =
                                            (buttonIndex == index);
                                      }
                                    });
                                  },
                                  selectedColor: Colors.white,
                                  fillColor: Colors
                                      .blue, // Set the background color when a button is selected
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderColor: Colors.blue,
                                  children: [
                                    // Female button
                                    Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: const Text(
                                        'Female',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    // Male button
                                    Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: const Text(
                                        'Male',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ], // Set the border color of buttons
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  'Address',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SelectState(
                                  onCountryChanged: (value) {
                                    setState(() {
                                      countryValue = value;
                                    });
                                  },
                                  onStateChanged: (value) {
                                    setState(() {
                                      stateValue = value;
                                    });
                                  },
                                  onCityChanged: (value) {
                                    setState(() {
                                      cityValue = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Building Number',
                                    hintText: 'Building Number',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Set the border radius
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Street Number',
                                    hintText: 'Street Number',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Set the border radius
                                    ),
                                  ),
                                ),
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
                          DropdownButton<String>(
                            value: selectedOption,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedOption = newValue!;
                              });
                            },
                            items: options
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
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
                            onPressed: continued,
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

  Widget buildCuisine() => TypeAheadFormField<String?>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controllerCuisine,
        decoration: InputDecoration(
          labelText: 'Favorite Cuisine',
          hintText: 'Choose Favorite Cuisine',
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(20.0), // Set the border radius
          ),
        ),
      ),
      //loading all the suggestions
      suggestionsCallback: CuisineData.getSuggestions,

      //displayig all the suggestion in a dropdown list
      itemBuilder: (context, String? suggestion) => ListTile(
            title: Text(suggestion!),
          ),
      //implement the suggestionselected so the typeAhead will works
      //Will get the item that was clicked
      onSuggestionSelected: (String? suggestion) {
        controllerCuisine.text = suggestion!;
      });
  Widget buildHangout() => TypeAheadFormField<String?>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controllerHangout,
        decoration: InputDecoration(
          labelText: 'Favorite Hangout Place',
          hintText: 'Choose Favorite Hangout Place',
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(20.0), // Set the border radius
          ),
        ),
      ),
      //loading all the suggestions
      suggestionsCallback: HangoutData.getSuggestions,

      //displayig all the suggestion in a dropdown list
      itemBuilder: (context, String? suggestion) => ListTile(
            title: Text(suggestion!),
          ),
      //implement the suggestionselected so the typeAhead will works
      //Will get the item that was clicked
      onSuggestionSelected: (String? suggestion) {
        controllerHangout.text = suggestion!;
      });
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
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
