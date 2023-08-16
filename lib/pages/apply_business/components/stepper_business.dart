import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/model/BusinessModel.dart';
import 'package:tim_app/pages/apply_business/components/stepper_one.dart';
import 'package:tim_app/pages/apply_business/components/stepper_three.dart';
import 'package:tim_app/pages/apply_business/components/stepper_two.dart';

import '../../../backend/firebase/userDataProvider.dart';
import '../../../backend/firebase/applyBusiness.dart';
import '../../../utils/loading.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({
    super.key,
  });

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
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    BusinessModel? business = BusinessModel.withDefaultValues();
    return Container(
      width: 900,
      height: 950,
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
            child: Stepper(
              type: StepperType.horizontal,
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
                  if (formKey3.currentState?.validate() == true) {
                    showCustomLoadingDialog(context, 'Applying business...');
                    formKey1.currentState!.save();
                    formKey2.currentState!.save();
                    formKey3.currentState!.save();
                    business.firstName = userProvider.userData?.firstName;
                    business.lastName = userProvider.userData?.lastName;
                    business.businessOwner = userProvider.userData?.docID;

                    business.businessImages?['logo'] = await uploadImage(
                        business.pickedLogo, business.businessName);
                    business.businessImages?['image1'] = await uploadImage(
                        business.pickedImage1, business.businessName);
                    business.businessImages?['image2'] = await uploadImage(
                        business.pickedImage2, business.businessName);
                    business.businessImages?['image3'] = await uploadImage(
                        business.pickedImage3, business.businessName);

                    String? result = await applyBusiness(business);
                    if (result == 'success') {
                      // ignore: use_build_context_synchronously
                      GoRouter.of(context).go('/dashboard');
                    }
                    // ADD Navigation: fix missing parameters in firestore (businessAddress, hours, links, phonenumber, businessSector, status)
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
                  content:
                      StepperThree(formKey: formKey3, businessModel: business),
                  isActive: currentStep == 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
