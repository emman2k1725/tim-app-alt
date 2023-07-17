import 'package:flutter/material.dart';
import 'package:tim_app/pages/loginpage/loginContainer.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/navBar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
          width: w,
          height: h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(mainBg),
            ),
          ),
          child: Center(child: LoginContainer()),
        ),
      ),
    );
  }
}
