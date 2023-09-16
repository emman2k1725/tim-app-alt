import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/utils/loading.dart';
import 'package:tim_app/widgets/customButtons.dart';

class AdminCreateAccount extends StatefulWidget {
  const AdminCreateAccount({super.key});

  @override
  State<AdminCreateAccount> createState() => _AdminCreateAccountState();
}

class _AdminCreateAccountState extends State<AdminCreateAccount> {
  TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String email = "";
  String password = "";
  String? selectedAdminUserAccess;
  List<String> adminUserAccess = [
    'Super Admin',
    'Admin',
  ];

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = UserModel();
    return AlertDialog(
      title: Text('Create New Admin Account'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                  hintText: 'First Name',
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
                                    return "Please Enter your first name";
                                  } else if (value.contains(RegExp(r'[0-9]'))) {
                                    return "Please Enter your a valid first name";
                                  } else {
                                    firstName = value;
                                    return null;
                                  }
                                }),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  hintText: 'Last Name',
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
                                    return "Please Enter your last name";
                                  } else if (value
                                      .contains(new RegExp(r'[0-9]'))) {
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
                          hintText: 'Phone Number',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        initialCountryCode: 'PH',
                        controller: phoneNumberController,
                        onChanged: (phone) {
                          phoneNumber = phone.completeNumber;
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else {
                            email = value;
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Temporary Password*',
                          hintText: 'Temporary Password',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          } else {
                            password = value;
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                'Access Level',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            DropdownButtonFormField<String>(
                              value: selectedAdminUserAccess,
                              items: adminUserAccess.map((sector) {
                                return DropdownMenuItem<String>(
                                  value: sector,
                                  child: Text(sector),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: 'Access Level',
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
                                  return 'Please enter your email';
                                } else {
                                  selectedAdminUserAccess = value;
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  selectedAdminUserAccess = value;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      actions: [
        CustomButton(
          text: 'Creating account',
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              showCustomLoadingDialog(context, 'Creating account...');
              Authenticate auth = Authenticate();
              String result = await auth.registerAdmin(email, password,
                  firstName, lastName, phoneNumber, selectedAdminUserAccess!);
              if (result == 'success') {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Successfully added new admin account')));
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(result)));
              }
            }
            // Handle button press
          },
        ),
      ],
    );
  }
}
