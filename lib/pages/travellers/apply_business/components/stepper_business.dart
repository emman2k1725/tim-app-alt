import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tim_app/backend/firebase/applyBusiness.dart';
import 'package:tim_app/model/BusinessModel.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/pages/travellers/apply_business/components/stepper_one.dart';
import 'package:tim_app/pages/travellers/apply_business/components/stepper_three.dart';
import 'package:tim_app/pages/travellers/apply_business/components/stepper_two.dart';
import 'package:tim_app/utils/loading.dart';
import 'package:tim_app/utils/responsive.dart';

class StepperWidget extends StatefulWidget {
  final UserModel? userProvider;
  const StepperWidget({super.key, required this.userProvider});

  @override
  _StepperWidgetState createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int currentStep = 0;

  StepperType stepperType = StepperType.vertical;
  // List<bool> isSelected = [false, false, false]; // Track the selected state of buttons
  List<String> buttonLabels = ['Option 1', 'Option 2'];
  List<bool> isSelected = [false, false]; // Track the selected state of buttons

  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    BusinessModel? business = BusinessModel.withDefaultValues();
    return Container(
      width: 900,
      height: 950,
      child: Column(
        children: [
          Expanded(

            child: Theme(
              data: ThemeData(
                canvasColor: Colors.transparent,
                hintColor: Colors.white,
                primarySwatch: Colors.blue,
                colorScheme: ColorScheme.light(primary: Colors.blue),
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide:
                        BorderSide(color: Colors.blue), // Set the border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide:
                        BorderSide(color: Colors.grey), // Set the border color
                  ),
                ),
              ),

            child: Stepper(
              type: Responsive.isDesktop(context)
                  ? StepperType.horizontal
                  : StepperType.vertical,
              currentStep: currentStep,
              onStepContinue: () async {
                if (currentStep == 0) {
                  if (formKey1.currentState?.validate() == true) {
                    setState(() {
                      currentStep++;
                    });
                  }
                } else if (currentStep == 1) {
                  if (formKey2.currentState?.validate() == true) {
                    setState(() {
                      currentStep++;
                    });
                  }
                } else if (currentStep == 2) {
                  debugPrint(widget.userProvider!.docID);
                  if (formKey3.currentState?.validate() == true) {
                    showCustomLoadingDialog(context, 'Applying business...');
                    formKey1.currentState!.save();
                    formKey2.currentState!.save();
                    formKey3.currentState!.save();
                    business.firstName = widget.userProvider?.firstName;
                    business.lastName = widget.userProvider?.lastName;
                    business.businessOwner = widget.userProvider?.docID;


                      business.businessImages?['logo'] = uploadImage(
                          business.pickedLogo, business.businessName);
                      business.businessImages?['image1'] = await uploadImage(
                          business.pickedImage1, business.businessName);
                      business.businessImages?['image2'] = await uploadImage(
                          business.pickedImage2, business.businessName);
                      business.businessImages?['image3'] = await uploadImage(
                          business.pickedImage3, business.businessName);

                      await applyBusiness(business).then((value) {
                        if (value == 'success') {
                          GoRouter.of(context).go('/dashboard');
                        } else {
                          debugPrint(value);
                        }
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
                  if (currentStep == 0) {
                    if (formKey1.currentState?.validate() == true) {
                      formKey1.currentState!.save();
                      setState(() {
                        currentStep = step;
                      });
                    }
                  } else if (currentStep == 1) {
                    if (formKey2.currentState?.validate() == true) {
                      formKey2.currentState!.save();
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
                    content:
                        StepperOne(formKey: formKey1, businessModel: business),
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
                    content: StepperTwo(
                      formKey: formKey2,
                      businessModel: business,
                    ),
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
                    content: StepperThree(
                        formKey: formKey3, businessModel: business),
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
