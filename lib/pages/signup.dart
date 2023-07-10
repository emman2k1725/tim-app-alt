import 'package:flutter/material.dart';
import 'package:tim_app/pages/loginpage/loginContainer.dart';
import 'package:tim_app/pages/signupcontainer.dart';
import 'package:tim_app/utils/constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: MediaQuery.sizeOf(context).height * 1.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(mainBg),
              ),
            ),
            child: const Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SignupContainer(),
                // MainContent()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
