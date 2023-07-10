import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/customButtons.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupContainer extends StatefulWidget {
  const SignupContainer({super.key});

  @override
  State<SignupContainer> createState() => _SignupContainerState();
}

class _SignupContainerState extends State<SignupContainer> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  // List<bool> isSelected = [false, false, false]; // Track the selected state of buttons
  List<String> buttonLabels = ['Option 1', 'Option 2'];
  List<bool> isSelected = [false, false]; // Track the selected state of buttons

  //Date picker
  TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;
  bool _isObscure = false;

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
        _dateController.text =
            DateFormat('EEEE, MMM d, yyyy').format(_selectedDate!);
      });
    }
  }

  //Phone number international coded
  TextEditingController phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  //city picker value
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: 800,
        height: 850,
        color: Colors.white,
        //      decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10.0), // Set the desired border radius
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey.withOpacity(0.5), // Set the shadow color
        //       spreadRadius: 2.0, // Set the spread radius
        //       blurRadius: 5.0, // Set the blur radius
        //       offset: Offset(0, 3), // Set the offset
        //     ),
        //   ],
        //   color: Colors.white, // Set the background color
        // ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(30, 20, 0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    logo,
                    width: 100,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Generated code for this Text Widget...
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    wordSpacing: 2.0,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          hintText: 'First Name',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your first name";
                          } else if (value.contains(new RegExp(r'[0-9]'))) {
                            return "Please Enter your a valid first name";
                          } else {
                            firstName = value;
                            return null;
                          }
                        }),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          hintText: 'Last Name',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your last name";
                          } else if (value.contains(new RegExp(r'[0-9]'))) {
                            return "Please Enter your a valid last name";
                          } else {
                            lastName = value;
                            return null;
                          }
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius:
                        BorderRadius.circular(20.0), // Set the border radius
                  ),
                ),
                initialCountryCode: 'PH', // Set the initial country code
                controller: phoneNumberController,
                onChanged: (phone) {
                  // Handle phone number changes
                  print(phone.completeNumber);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius:
                        BorderRadius.circular(20.0), // Set the border radius
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else {
                    email = value;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                    hintText: 'Password',
                    suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius:
                          BorderRadius.circular(20.0), // Set the border radius
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    } else if (value.length < 9) {
                      return "Password must be atleast 9 characters";
                    } else {
                      password = value;
                      return null;
                    }
                  }),
              const SizedBox(height: 16.0),
              TextFormField(
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    labelText: 'Confirm your password',
                    hintText: 'Confirm Password',
                    suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius:
                          BorderRadius.circular(20.0), // Set the border radius
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please confirm your password";
                    } else if (value != password) {
                      return "Does not match your password";
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(height: 16.0),
              CustomButton(
                text: 'Sign up',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    registerWithEmailPassword(
                        email, password, phoneNumber, firstName, lastName);
                  }
                  // Handle button press
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                '- OR - ',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  wordSpacing: 2.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    height: 40,
                    width: 200,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle the login with Facebook action
                      },
                      icon: Image.asset(
                        fbLogo,
                        width: 30.0,
                        height: 30.0,
                      ),
                      label: const Text('Login with Facebook'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    height: 40,
                    width: 180,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle the login with Facebook action
                      },
                      icon: Image.asset(
                        googleLogo,
                        width: 30.0,
                        height: 30.0,
                      ),
                      label: const Text('Login with Google'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

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
