import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:tim_app/pages/apply_business/components/stepper_one.dart';
import 'package:tim_app/pages/apply_business/components/stepper_three.dart';
import 'package:tim_app/pages/apply_business/components/stepper_two.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({Key? key}) : super(key: key);

  @override
  _StepperWidgetState createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int currentStep = 0;

  StepperType stepperType = StepperType.vertical;
  // List<bool> isSelected = [false, false, false]; // Track the selected state of buttons
  List<String> buttonLabels = ['Option 1', 'Option 2'];
  List<bool> isSelected = [false, false]; // Track the selected state of buttons
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 900,
      height: 700,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.white, // Border color
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(10.0), // Border radius
      ),
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: Stepper(
                type: StepperType.horizontal,
                currentStep: currentStep,
                onStepContinue: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (currentStep < 2) {
                      setState(() {
                        currentStep++;
                      });
                    }
                  }
                },
                onStepCancel: () {
                  setState(() {
                    if (currentStep > 0) {
                      currentStep--;
                    }
                  });
                },
                onStepTapped: (step) {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (currentStep < 2) {
                      setState(() {
                        currentStep = step;
                      });
                    }
                  }
                },
                steps: [
                  Step(
                    title: const Text(
                      'Business Profile',
                      style: TextStyle(
                        fontSize: 18.0, // Set the font size
                        color: Colors.blue, // Set the text color
                      ),
                    ),
                    content: const StepperOne(),
                    isActive: currentStep == 0,
                  ),
                  Step(
                    title: const Text(
                      'Business Details',
                      style: TextStyle(
                        fontSize: 18.0, // Set the font size
                        color: Colors.blue, // Set the text color
                      ),
                    ),
                    content: const StepperTwo(),
                    isActive: currentStep == 1,
                  ),
                  Step(
                    title: const Text(
                      'Operating Hours',
                      style: TextStyle(
                        fontSize: 18.0, // Set the font size
                        color: Colors.blue, // Set the text color
                      ),
                    ),
                    content: const StepperThree(),
                    isActive: currentStep == 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
