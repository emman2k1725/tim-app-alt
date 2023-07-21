import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tim_app/backend/firebase/UserDataProvider.dart';
import 'package:tim_app/pages/signup.dart';
import 'package:tim_app/utils/appTheme_style.dart';
import 'package:tim_app/utils/colors.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/widgets/customButtons.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../../responsive.dart';
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

class _LoginContainerState extends State<LoginContainer> {
  Color shadowColor = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);

    return Center(
      child: Container(
          height: 550,
          // May error dito kapag horizontal: w! / 10. Kapag bumabalik galing sa ibang page, nagiging null lamang ni variable: w
          margin: EdgeInsets.symmetric(horizontal: w! / 10, vertical: 20),
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
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintStyle: TextStyle(
                                          color: Colors
                                              .blue, // Set the desired hint text color
                                        ),
                                        labelText: 'Email',
                                        hintText: 'Enter your email',
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
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
                                          email = value;
                                          return null;
                                        }
                                      },
                                    ),

                                    const SizedBox(height: 16.0),
                                    TextFormField(
                                      obscureText: _isObscure,
                                      decoration: InputDecoration(
                                        filled: true,
                                        hintStyle: TextStyle(
                                          color: Colors
                                              .blue, // Set the desired hint text color
                                        ),
                                        fillColor: Colors.white,
                                        labelText: 'Password',
                                        hintText: 'Enter your password',
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
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              20.0), // Set the border radius
                                        ),
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
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                    const SizedBox(height: 16.0),
                                    Center(
                                      child: CustomButton(
                                        text: 'Sign in',
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            String result = await authProvider
                                                .signIn(email, password);
                                            if (result == 'success') {
                                              showCustomLoadingDialog(
                                                  context, 'Logging in...');
                                              String userDataRes =
                                                  await userProvider
                                                      .getUserInfo(authProvider
                                                          .user!.uid);
                                              if (userDataRes == 'success') {
                                                nagivateGateway(
                                                    userProvider
                                                        .userData!.isAdmin,
                                                    userProvider.userData!
                                                        .isRegistrationComplete,
                                                    context);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content:
                                                            Text(userDataRes)));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(result)));
                                            }
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
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const SignupPage()));
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
                        SizedBox(
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
                        // Container(
                        //   decoration: const BoxDecoration(
                        //     borderRadius: BorderRadius.only(
                        //       topRight: Radius.circular(50.0),
                        //       bottomRight: Radius.circular(50.0),
                        //     ),
                        //   ),
                        //   height: 530,
                        //   child: Image.asset(
                        //     timHand,
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
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
    // Admin
  }
}
