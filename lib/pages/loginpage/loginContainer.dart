import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tim_app/pages/signup.dart';
import 'package:tim_app/utils/colors.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/widgets/customButtons.dart';

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
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: mobileContainer1(),
      desktop: desktopContainer1(),
    );
  }
  //================ MOBILE ===============

  Widget mobileContainer1() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w! / 10, vertical: 20),
      child: Column(
        children: [
          Container(
            height: w! / 1.2,
            width: w! / 1.2,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(homepageTim), fit: BoxFit.contain)),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Unforgettable \nExperiences Awaits',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: w! / 10,
                fontWeight: FontWeight.bold,
                height: 1),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Capturing the Perfect Shots in Picture-Perfect Destinations',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 45,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primary)),
                onPressed: () {},
                child: const Text('Plan Now')),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 45,
            child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    side: const BorderSide(
                      width: 1.0,
                      color: Colors.transparent,
                    )),
                icon: const Icon(Icons.play_arrow_outlined),
                label: const Text('How it works')),
          ),
          // ElevatedButton.icon(
          //       style: ButtonStyle(
          //           backgroundColor: Color(0x34E8E8E8)),
          //       onPressed: () {},
          //       icon: const Icon(Icons.play_arrow_outlined),
          //       label: const Text('Plan Now')),
        ],
      ),
    );
  }

  //============== DESKTOP =============

  Widget desktopContainer1() {
    return Container(
      height: 530,
      margin: EdgeInsets.symmetric(horizontal: w! / 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ), // Set the desired border radius
                child: Container(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    height: 530,
                    color: Colors.white,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                30, 20, 0, 0),
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                wordSpacing: 2.0,
                              ),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                            child: Text(
                              'Begin your journey by signing in to your account',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                letterSpacing: 1.5,
                                wordSpacing: 2.0,
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter your email',
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
                                email = value;
                                return null;
                              }
                            },
                          ),

                          const SizedBox(height: 16.0),
                          TextFormField(
                            obscureText: _isObscure,
                            decoration: InputDecoration(
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
                                return 'Please enter your password';
                              } else {
                                password = value;
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 16.0),
                          CustomButton(
                            text: 'Sign in',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                loginWithEmailPassword(
                                    email, password, context);
                              }
                              // Handle button press
                            },
                          ),
                          const SizedBox(height: 16.0),
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
                          const SizedBox(height: 16.0),
                          RichText(
                            text: TextSpan(
                              text: 'Dont have an account? ',
                              style: DefaultTextStyle.of(context).style,
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

                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
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
                        ],
                      ),
                    ) // Generated code for this Image Widget...

                    //  child: Column(
                    //   children: [

                    //     //    ClipRRect(
                    //     //     borderRadius: BorderRadius.circular(8),
                    //     //     child: Image.asset(
                    //     //       logo,
                    //     //       width: 100,
                    //     //       fit: BoxFit.fitWidth,
                    //     //     ),

                    //     // )

                    //   ],
                    //  ),
                    ),
              ),
            ]),
          ),

          SizedBox(
            height: 530,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 50, 0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(40),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(40),
                ),
                child: Image.asset(
                  timHand,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          //    Container(
          //   height: 530,
          //   decoration: const BoxDecoration(
          //       image: DecorationImage(
          //           image: AssetImage(timHand), fit: BoxFit.contain
          //           ))
          // ),
        ],
      ),
    );
  }
}
