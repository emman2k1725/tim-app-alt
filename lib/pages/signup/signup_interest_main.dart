import 'package:flutter/material.dart';
import 'package:tim_app/pages/signup/components/signup_interest.dart';
import 'package:tim_app/utils/constants.dart';

class InterestMain extends StatefulWidget {
  const InterestMain({super.key});

  @override
  State<InterestMain> createState() => _InterestMainState();
}

class _InterestMainState extends State<InterestMain> {
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(mainBg),
          ),
        ),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              InterestSignup(),
            ],
          ),
        ),
      ),
    );
  }
}
