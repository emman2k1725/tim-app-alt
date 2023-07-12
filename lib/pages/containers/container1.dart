import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tim_app/utils/colors.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';

import '../../responsive.dart';

class Container1 extends StatefulWidget {
  const Container1({Key? key}) : super(key: key);

  @override
  _Container1State createState() => _Container1State();
}

class _Container1State extends State<Container1> {
  @override
  Widget build(BuildContext context) {
    /*return ScreenTypeLayout(
      mobile: mobileContainer1(),
      desktop: desktopContainer1(),
    );*/
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w! / 10, vertical: 5),
      child: Responsive.isDesktop(context)
          ? desktopContainer1()
          : mobileContainer1(),
    );
  }

  //================ MOBILE ===============
  Widget mobileContainer1() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w! / 10, vertical: 5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: h! / 3,
            //   width: w! / 2,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage(homepageTim),
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: h! / 3,
              width: w! / 2,
              child: const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Image(
                  image: AssetImage(homepageTim),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            //const SizedBox(height: 30),
            Center(
              child: Text(
                'Unforgettable \nExperiences Awaits',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w! / 12,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Capturing the Perfect Shots in Picture-Perfect Destinations',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primary),
                    ),
                    onPressed: () {},
                    child: const Text('Plan Now'),
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      side: const BorderSide(
                        width: 1.0,
                        color: Colors.transparent,
                      ),
                    ),
                    icon: const Icon(Icons.play_arrow_outlined),
                    label: const Text('How it works'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /*Widget mobileContainer1() {
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
  }*/

  //============== DESKTOP =============
  Widget desktopContainer1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: Container(
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Unforgettable \nExperiences Awaits',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: w! / 20,
                    fontWeight: FontWeight.bold,
                    height: 1),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Capturing the Perfect Shots in Picture-Perfect Destinations',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        style: elevatedButtonStyle,
                        onPressed: () {},
                        child: const Text(
                          'Get Started',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 45,
                    child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            side: const BorderSide(
                              width: 1.0,
                              color: Colors.transparent,
                            )),
                        icon: const Icon(Icons.play_arrow_outlined),
                        label: const Text('How it works')),
                  ),
                ],
              ),
            ],
          ),
        )),
        Expanded(
          child: Container(
              height: 530,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(homepageTim), fit: BoxFit.contain))),
        ),
      ],
    );
  }
  /*Widget desktopContainer1() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w! / 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: Container(
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unforgettable \nExperiences Awaits',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: w! / 20,
                      fontWeight: FontWeight.bold,
                      height: 1),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Capturing the Perfect Shots in Picture-Perfect Destinations',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          style: elevatedButtonStyle,
                          onPressed: () {},
                          child: const Text(
                            'Get Started',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 45,
                      child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              side: const BorderSide(
                                width: 1.0,
                                color: Colors.transparent,
                              )),
                          icon: const Icon(Icons.play_arrow_outlined),
                          label: const Text('How it works')),
                    ),
                  ],
                ),
              ],
            ),
          )),
          Expanded(
            child: Container(
                height: 530,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(homepageTim), fit: BoxFit.contain))),
          ),
        ],
      ),
    );
  }*/
}
