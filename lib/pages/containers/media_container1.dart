// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../responsive.dart';
import '../../utils/appTheme_style.dart';
import '../../utils/constants.dart';
import '../../utils/styles.dart';

class MediaContainer1 extends StatefulWidget {
  const MediaContainer1({super.key});

  @override
  State<MediaContainer1> createState() => _MediaContainer1State();
}

class _MediaContainer1State extends State<MediaContainer1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? w! / 10 : w! / 30,
          vertical: 5),
      child: Responsive.isDesktop(context)
          ? desktopContainer1()
          : mobileContainer1(),
    );
  }

  //============== DESKTOP =============
  Widget desktopContainer1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Media',
          style: AppTheme.getSecondaryTextStyle(50.0),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  height: h!,
                  width: w! / 150,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(mediaImg), fit: BoxFit.cover))),
            ),
            SizedBox(
              width: 60,
            ),
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Lorem ipsum dolor sit amet',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: 5,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 20);
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      height: 200,
                                      width: 150,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(beach),
                                              fit: BoxFit.cover))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'Friday | 18 AUG',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              color: Colors.grey.shade800,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu nibh nec augue blandit condimentum sed sed turpis. Quisque suscipit orci non velit tempus, eget congue leo tincidunt. ',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                'View',
                                                style: TextStyle(
                                                  color: Colors.grey.shade800,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      size: 15)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )),
          ],
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  //================ MOBILE ===============
  Widget mobileContainer1() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            //  Container(
            //       height: h!,
            //       width: w! / 150,
            //       decoration: const BoxDecoration(
            //           image: DecorationImage(
            //               image: AssetImage(mediaImg), fit: BoxFit.cover))),
            Center(
              child: Text(
                'Media',
                style: AppTheme.getSecondaryTextStyle(30.0),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: h! / 2,
              width: w! / 1,
              child: const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Image(
                  image: AssetImage(mediaImg),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Lorem ipsum dolor sit amet',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Colors.white,
            ),
            SizedBox(
              height: 20,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: 5,
              separatorBuilder: (context, index) {
                return SizedBox(height: 20);
              },
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                              height: 200,
                              width: 150,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(beach),
                                      fit: BoxFit.cover))),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Friday | 18 AUG',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu nibh nec augue blandit condimentum sed sed turpis. Quisque suscipit orci non velit tempus, eget congue leo tincidunt. ',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'View',
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 15,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 15)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
