import 'dart:convert';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/atoms/button.dart';
import 'package:tim_app/backend/firebase/userDataProvider.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/pages/signup.dart';
import 'package:tim_app/utils/appTheme_style.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/utils/responsive.dart';
import 'package:tim_app/widgets/customButtons.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../../backend/firebase/firebaseService.dart';
import '../../custom_dialog.dart';
import '../../utils/loading.dart';

class SignupContainer extends StatefulWidget {
  const SignupContainer({super.key});

  @override
  State<SignupContainer> createState() => _SignupContainerState();
}

bool _isObscure = true;
final _formKey = GlobalKey<FormState>();

//city picker value
String firstName = "";
String lastName = "";
String phoneNumber = "";
String email = "";
String password = "";

//Phone number international coded
TextEditingController phoneNumberController = TextEditingController();

class _SignupContainerState extends State<SignupContainer> {
  Color shadowColor = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.7; // 70% of the screen width
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    return Center(
      child: Container(
          width: containerWidth,
          height: 600,
          // May error dito kapag horizontal: w! / 10. Kapag bumabalik galing sa ibang page, nagiging null lamang ni variable: w
          margin: EdgeInsets.symmetric(
              horizontal: Responsive.isDesktop(context) ? w! / 10 : 20,
              vertical: 20),
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
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      color: Colors.white,
                                      icon: const Icon(Icons.arrow_back),
                                      onPressed: () {
                                        GoRouter.of(context).go('/login');
                                      },
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10, 0, 0, 10),
                                      child: Center(
                                        child: Text(
                                          'Sign up',
                                          style: AppTheme.getSecondaryTextStyle(
                                              25),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 10),
                                      child: Center(
                                        child: Text(
                                          'Start your adventure today! Join TIM to embark on a journey like no other.',
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
                                      height: 5,
                                    ),
                                    const SizedBox(height: 16.0),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: TextFormField(
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  labelText: 'First Name',
                                                  hintText: 'First Name',
                                                  labelStyle: TextStyle(
                                                      color: Colors.white),
                                                  hintStyle: TextStyle(
                                                      color: Colors.white),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Colors.blue),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 3,
                                                        color:
                                                            Colors.blueAccent),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Please Enter your first name";
                                                  } else if (value.contains(
                                                      RegExp(r'[0-9]'))) {
                                                    return "Please Enter your a valid first name";
                                                  } else {
                                                    firstName = value;
                                                    return null;
                                                  }
                                                })),
                                        const SizedBox(width: 10.0),
                                        Expanded(
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                labelText: 'Last Name',
                                                hintText: 'Last Name',
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Colors.blueAccent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Please Enter your last name";
                                                } else if (value.contains(
                                                    new RegExp(r'[0-9]'))) {
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
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        hintText: 'Enter your email',
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.blue,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Colors.blueAccent),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email';
                                        } else {
                                          email = value;
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 16.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: Colors.white),
                                              obscureText: _isObscure,
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Enter your password',
                                                hintText: 'Password',
                                                suffixIcon: IconButton(
                                                    color: Colors.white,
                                                    icon: Icon(_isObscure
                                                        ? Icons.visibility
                                                        : Icons.visibility_off),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isObscure =
                                                            !_isObscure;
                                                      });
                                                    }),
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 2,
                                                    color: Colors.blue,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Colors.blueAccent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Please enter your password";
                                                } else if (value.length < 9) {
                                                  return "Password must be atleast 9 characters";
                                                } else {
                                                  password = value;
                                                  return null;
                                                }
                                              }),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Expanded(
                                          child: TextFormField(
                                              style: TextStyle(
                                                  color: Colors.white),
                                              obscureText: _isObscure,
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Confirm your password',
                                                hintText: 'Confirm Password',
                                                suffixIcon: IconButton(
                                                    color: Colors.white,
                                                    icon: Icon(_isObscure
                                                        ? Icons.visibility
                                                        : Icons.visibility_off),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isObscure =
                                                            !_isObscure;
                                                      });
                                                    }),
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 2,
                                                    color: Colors.blue,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Colors.blueAccent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Please confirm your password";
                                                } else if (value != password) {
                                                  return "Does not match your password";
                                                } else {
                                                  return null;
                                                }
                                              }),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16.0),
                                    Center(
                                      child: GradientButton(
                                        text: 'Sign Up Account',
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            showCustomLoadingDialog(
                                                context, 'Signing up...');
                                            Authenticate auth = Authenticate();
                                            String result = await auth.register(
                                                email,
                                                password,
                                                firstName,
                                                lastName,
                                                phoneNumber);
                                            if (result == 'success') {
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Sign up sucessful! You can now login your account')));
                                              GoRouter.of(context).go('/');
                                            } else {
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(result)));
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    // const Center(
                                    //   child: Padding(
                                    //     padding: EdgeInsetsDirectional.fromSTEB(
                                    //         10, 0, 0, 10),
                                    //     child: Text(
                                    //       '- OR -',
                                    //       style: TextStyle(
                                    //         color: Colors.white,
                                    //         fontSize: 12.0,
                                    //         letterSpacing: 1.5,
                                    //         wordSpacing: 2.0,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.center,
                                    //   children: [
                                    //     Expanded(
                                    //       child: Container(
                                    //         decoration: BoxDecoration(
                                    //           borderRadius:
                                    //               BorderRadius.circular(20),
                                    //           color: Colors.blue,
                                    //         ),
                                    //         height: 40,
                                    //         child: ElevatedButton.icon(
                                    //           onPressed: () {
                                    //             // Handle the login with Facebook action
                                    //           },
                                    //           icon: Image.asset(
                                    //             fbLogo,
                                    //             width: 30.0,
                                    //             height: 30.0,
                                    //           ),
                                    //           label: const Text(
                                    //               'Sign up with Facebook'),
                                    //           style: ElevatedButton.styleFrom(
                                    //             primary: Colors.white,
                                    //             onPrimary: Colors.black,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     const SizedBox(width: 16.0),
                                    //     Expanded(
                                    //       child: Container(
                                    //         decoration: BoxDecoration(
                                    //           borderRadius:
                                    //               BorderRadius.circular(10),
                                    //           color: Colors.blue,
                                    //         ),
                                    //         height: 40,
                                    //         width: 180,
                                    //         child: ElevatedButton.icon(
                                    //           onPressed: () {
                                    //             // Handle the login with Facebook action
                                    //           },
                                    //           icon: Image.asset(
                                    //             googleLogo,
                                    //             width: 30.0,
                                    //             height: 30.0,
                                    //           ),
                                    //           label: const Text(
                                    //               'Sign up with Google'),
                                    //           style: ElevatedButton.styleFrom(
                                    //             primary: Colors.white,
                                    //             onPrimary: Colors.black,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    const SizedBox(height: 16.0),
                                    Center(
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Do you have account? ',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Sign in',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  GoRouter.of(context)
                                                      .go('/login');
                                                },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Responsive.isDesktop(context)
                            ? Expanded(
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
                            : SizedBox(height: 0),
                      ],
                    ),
                  )))),
    );
  }
}

void nagivateGateway(
    bool? asAdmin, bool? isRegistrationComplete, BuildContext context) {
  if (asAdmin == false) {
    if (isRegistrationComplete == false) {
      GoRouter.of(context).go('/signup-interest');
    } else {
      GoRouter.of(context).go('/dashboard');
    }
  } else {
    GoRouter.of(context).go('/admin-dashboard');
  }
}

void _showRowDialog(
    /*Map<String, dynamic> item*/ String item, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: 'Forgot Password',
        message: 'Insert text here',
      );
    },
  );
}
