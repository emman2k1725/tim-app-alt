// import 'package:country_state_city_picker/country_state_city_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';

// class SignupContainer extends StatefulWidget {
//   const SignupContainer({super.key});

//   @override
//   State<SignupContainer> createState() => _SignupContainerState();
// }

// class _SignupContainerState extends State<SignupContainer> {
// int _currentStep = 0;
//   StepperType stepperType = StepperType.vertical;
//   // List<bool> isSelected = [false, false, false]; // Track the selected state of buttons
//   List<String> buttonLabels = ['Option 1', 'Option 2'];
//   List<bool> isSelected = [false, false]; // Track the selected state of buttons

//   //Date picker
//   TextEditingController _dateController = TextEditingController();
//   DateTime? _selectedDate;

//   void _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );

//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//         _dateController.text = DateFormat('EEEE, MMM d, yyyy').format(_selectedDate!);
//       });
//     }
//   }

//   //image picker
//   // File? _image;

//   // Future<void> _pickImage() async {
//   //   final picker = ImagePicker();
//   //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//   //   setState(() {
//   //     _image = pickedImage != null ? File(pickedImage.path) : null;
//   //   });
//   // }

//   //Phone number international coded
//   TextEditingController phoneNumberController = TextEditingController();

//   //city picker value
//   String countryValue = "";
//   String stateValue = "";
//   String cityValue = "";
//   String address = "";

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 500,
//       height: 650,
//       color: Colors.white,
//       child: Column(
//         children: [
//           Expanded(
//             child: Stepper(
//               elevation: 0, //Horizontal Impact
//               type: StepperType.horizontal,
//               physics: const ScrollPhysics(),
//               currentStep: _currentStep,
//               onStepTapped: (step) => tapped(step),
//               onStepContinue: continued,
//               onStepCancel: cancel,
//               steps: <Step>[
//                 Step(
//                   title: const Text('Personal Information'),
//                   content: Container(
//                     color: Colors.white, // Set the background color of Step 1
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: TextFormField(
//                                 decoration: InputDecoration(
//                                   labelText: 'First Name',
//                                   hintText: 'First Name',
//                                   border: OutlineInputBorder(
//                                     borderSide: const BorderSide(color: Colors.blue),
//                                     borderRadius: BorderRadius.circular(
//                                         20.0), // Set the border radius
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 10.0),
//                             Expanded(
//                               child: TextFormField(
//                                 decoration: InputDecoration(
//                                   labelText: 'Last Name',
//                                   hintText: 'Last Name',
//                                   border: OutlineInputBorder(
//                                     borderSide: const BorderSide(color: Colors.blue),
//                                     borderRadius: BorderRadius.circular(
//                                         20.0), // Set the border radius
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16.0),
//                         TextFormField(
//                           controller: _dateController,
//                           readOnly: true,
//                           onTap: () => _selectDate(context),
//                           decoration: InputDecoration(
//                             labelText: 'Date of Birth',
//                             prefixIcon: const Icon(Icons.calendar_today),
//                             border: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.blue),
//                               borderRadius: BorderRadius.circular(
//                                   20.0), // Set the border radius
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16.0),
//                         IntlPhoneField(
//                           decoration: InputDecoration(
//                             labelText: 'Phone Number',
//                             border: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.blue),
//                               borderRadius: BorderRadius.circular(
//                                   20.0), // Set the border radius
//                             ),
//                           ),
//                           initialCountryCode:
//                               'US', // Set the initial country code
//                           controller: phoneNumberController,
//                           onChanged: (phone) {
//                             // Handle phone number changes
//                             print(phone.completeNumber);
//                           },
//                         ),
//                         const SizedBox(height: 16.0),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Gender',
//                               style: TextStyle(
//                                   fontSize: 16.0, fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(height: 16.0),
//                             // SelectState(
//                             //   onCountryChanged: (value) {
//                             //     setState(() {
//                             //       countryValue = value;
//                             //     });
//                             //   },
//                             //   onStateChanged: (value) {
//                             //     setState(() {
//                             //       stateValue = value;
//                             //     });
//                             //   },
//                             //   onCityChanged: (value) {
//                             //     setState(() {
//                             //       cityValue = value;
//                             //     });
//                             //   },
//                             // ),
//                             ToggleButtons(
//                               isSelected: isSelected,
//                               onPressed: (index) {
//                                 setState(() {
//                                   // Update the selected state of buttons
//                                   for (int buttonIndex = 0;
//                                       buttonIndex < isSelected.length;
//                                       buttonIndex++) {
//                                     isSelected[buttonIndex] =
//                                         (buttonIndex == index);
//                                   }
//                                 });
//                               },
//                               selectedColor: Colors.white,
//                               fillColor: Colors
//                                   .blue, // Set the background color when a button is selected
//                               borderRadius: BorderRadius.circular(10.0),
//                               borderColor: Colors
//                                   .blue,
//                               children: [
//                                 // Female button
//                                 Container(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: const Text(
//                                     'Female',
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                     ),
//                                   ),
//                                 ),
//                                 // Male button
//                                 Container(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: const Text(
//                                     'Male',
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                     ),
//                                   ),
//                                 ),
//                               ], // Set the border color of buttons
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   isActive: _currentStep >= 0,
//                   state: _currentStep >= 0
//                       ? StepState.complete
//                       : StepState.disabled,
//                 ),
//                 Step(
//                   title: new Text('Business Info'),
//                   content: Column(
//                     children: <Widget>[
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Company Name',
//                           hintText: 'Company Name',
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.blue),
//                             borderRadius: BorderRadius.circular(
//                                 20.0), // Set the border radius
//                           ),
//                         ),
//                       ),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Name of Business',
//                           hintText: 'Name of Business',
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.blue),
//                             borderRadius: BorderRadius.circular(
//                                 20.0), // Set the border radius
//                           ),
//                         ),
//                       ),
//                       const Text(
//                         'Company Address',
//                         style: TextStyle(
//                             fontSize: 16.0, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 16.0),
//                       SelectState(
//                         onCountryChanged: (value) {
//                           setState(() {
//                             countryValue = value;
//                           });
//                         },
//                         onStateChanged: (value) {
//                           setState(() {
//                             stateValue = value;
//                           });
//                         },
//                         onCityChanged: (value) {
//                           setState(() {
//                             cityValue = value;
//                           });
//                         },
//                       ),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Business Sector',
//                           hintText: 'Business Sector',
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.blue),
//                             borderRadius: BorderRadius.circular(
//                                 20.0), // Set the border radius
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       IntlPhoneField(
//                         decoration: InputDecoration(
//                           labelText: 'Phone Number',
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.blue),
//                             borderRadius: BorderRadius.circular(
//                                 20.0), // Set the border radius
//                           ),
//                         ),
//                         initialCountryCode:
//                             'US', // Set the initial country code
//                         controller: phoneNumberController,
//                         onChanged: (phone) {
//                           // Handle phone number changes
//                           print(phone.completeNumber);
//                         },
//                       ),
//                     ],
//                   ),
//                   isActive: _currentStep >= 0,
//                   state: _currentStep >= 1
//                       ? StepState.complete
//                       : StepState.disabled,
//                 ),
//                 Step(
//                   title: new Text('Other Information'),
//                   content: Column(
//                     children: <Widget>[
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Google Map Link',
//                           hintText: 'Google Map Link',
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.blue),
//                             borderRadius: BorderRadius.circular(
//                                 20.0), // Set the border radius
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Google Map Link',
//                           hintText: 'Google Map Link',
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.blue),
//                             borderRadius: BorderRadius.circular(
//                                 20.0), // Set the border radius
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Business Description',
//                           hintText: 'Business Description max of 50 words',
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.blue),
//                             borderRadius: BorderRadius.circular(
//                                 20.0), // Set the border radius
//                           ),
//                         ),
//                         keyboardType: TextInputType.multiline,
//                         minLines: 1,
//                         maxLines: 5,
//                       ),
//                       // Center(
//                       //   child: Column(
//                       //     mainAxisAlignment: MainAxisAlignment.center,
//                       //     children: <Widget>[
//                       //       if (_image != null) Image.file(_image!),
//                       //       ElevatedButton(
//                       //         onPressed: _pickImage,
//                       //         child: Text('Pick Image'),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                   isActive: _currentStep >= 0,
//                   state: _currentStep >= 2
//                       ? StepState.complete
//                       : StepState.disabled,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   switchStepsType() {
//     setState(() => stepperType == StepperType.vertical
//         ? stepperType = StepperType.horizontal
//         : stepperType = StepperType.vertical);
//   }

//   tapped(int step) {
//     setState(() => _currentStep = step);
//   }

//   continued() {
//     _currentStep < 2 ? setState(() => _currentStep += 1) : null;
//   }

//   cancel() {
//     _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
//   }
// }





