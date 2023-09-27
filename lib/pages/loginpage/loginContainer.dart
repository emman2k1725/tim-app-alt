import 'dart:convert';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

bool _isObscure = true;
final _formKey = GlobalKey<FormState>();

String email = "";
String password = "";
String loggedUser = "";

class _LoginContainerState extends State<LoginContainer> {
  Color shadowColor = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    return Center(
      child: Container(
          height: 550,
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
                              height: 530,
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
                                        GoRouter.of(context).go('/');
                                      },
                                    ),
                                    Center(
                                      child: Image.asset(
                                        logo,
                                        width: 60,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 25,
                                    ),
                                    // Generated code for this Text Widget...
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10, 0, 0, 10),
                                      child: Center(
                                        child: Text(
                                          'Sign in',
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
                                          'Adventure awaits. Pack your bags and let your journey begin.',
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

                                    TextFormField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        hintText: 'Enter your email',
                                        labelStyle: const TextStyle(
                                            color: Colors.white),
                                        hintStyle: const TextStyle(
                                            color: Colors.white),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: Colors.blue),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
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
                                    TextFormField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      obscureText: _isObscure,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        hintText: 'Enter your password',
                                        labelStyle: const TextStyle(
                                            color: Colors.white),
                                        hintStyle: const TextStyle(
                                            color: Colors.white),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: Colors.blue),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 3,
                                              color: Colors.blueAccent),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        suffixIcon: IconButton(
                                            color: Colors.white,
                                            icon: Icon(_isObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            onPressed: () {
                                              setState(() {
                                                _isObscure = !_isObscure;
                                              });
                                            }),
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        } else {
                                          password = value;
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 10.0),
                                    InkWell(
                                      onTap: () {
                                        _showRowDialog('', context);
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Forgot Password',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              letterSpacing: 1.5,
                                              wordSpacing: 2.0,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    Center(
                                      child: CustomButton(
                                        text: 'Sign in',
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            showCustomLoadingDialog(
                                                context, 'Logging in...');
                                            Authenticate auth = Authenticate();
                                            SharedPreferences preference =
                                                await SharedPreferences
                                                    .getInstance();
                                            auth
                                                .signIn(email, password)
                                                .then((value) {
                                              if (value == "success") {
                                                fetchDocumentbyID(
                                                        auth.user!.uid,
                                                        'user_profile')
                                                    .then((value) async {
                                                  UserModel userData =
                                                      UserModel.fromMap(value);
                                                  preference.setString(
                                                      'user',
                                                      jsonEncode(
                                                          userData.toJson()));
                                                  userProvider
                                                      .loadDataFromSharedPref();
                                                  Navigator.pop(context);
                                                  nagivateGateway(
                                                      userData.isAdmin,
                                                      userData
                                                          .isRegistrationComplete,
                                                      context);
                                                });
                                              } else {
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Please Enter Correct Credentials')));
                                              }
                                            });
                                          }
                                          // Handle button press
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    const Center(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 10),
                                        child: Text(
                                          '- OR -',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            letterSpacing: 1.5,
                                            wordSpacing: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                            label: const Text(
                                                'Login with Facebook'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              onPrimary: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16.0),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                            label:
                                                const Text('Login with Google'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              onPrimary: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16.0),
                                    Center(
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Dont have an account? ',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Sign up',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  GoRouter.of(context)
                                                      .go('/signup');
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
                            ? SizedBox(
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
                            : const SizedBox(height: 0),
                      ],
                    ),
                  )))),
    );
  }

  void _showRowDialog(
      /*Map<String, dynamic> item*/ String item, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Forgot Password'),
              SizedBox(
                height: 5,
              ),
              Text(
                'Please provide the email address that you used when you signed up for your account.',
                textAlign: TextAlign.left,
                softWrap: true,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 400,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          labelText: 'Enter Email Address',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'An email will been sent to your account. Check your inbox and click the reset link provided.',
                        textAlign: TextAlign.left,
                        softWrap: true,
                        // Other text style properties can be added here
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        text: 'Reset Password',
                        onPressed: () async {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
