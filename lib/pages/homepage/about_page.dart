// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/backend/firebase/userDataProvider.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/widgets/appbar.dart';

import '../../ads_footer.dart';
import '../../backend/firebase/fetchTable.dart';
import '../../responsive.dart';
import '../../utils/appTheme_style.dart';
import '../../utils/constants.dart';
import '../../utils/styles.dart';
import '../../widgets/navBar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0xFF333334),
        toolbarHeight: Responsive.isDesktop(context) ? 78 : 65,
        elevation: 4,
        titleSpacing: 0,
        title: NavBar(),
      ),
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(mainBg),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 130,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal:
                        Responsive.isDesktop(context) ? w! / 10 : w! / 20,
                    vertical: 5),
                child: Responsive.isDesktop(context)
                    ? DesktopContainer1()
                    : MobileContainer1(),
              ),
              AdsFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

class DesktopContainer1 extends StatelessWidget {
  const DesktopContainer1({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fetchTableContent('About'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (snapshot.hasData) {
            final List<Map<String, dynamic>> data =
                snapshot.data!.docs.map((DocumentSnapshot document) {
              return document.data() as Map<String, dynamic>;
            }).toList();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                  // color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About Us',
                        style: AppTheme.getSecondaryTextStyle(50.0),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'See how TIM can help you in promoting your business',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        data[0]['contentTitle'] ?? '',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        data[0]['description'] ?? '',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ElevatedButton(
                              style: elevatedButtonStyle,
                              onPressed: () {
                                GoRouter.of(context).go('/about');
                              },
                              child: const Text(
                                'SIGN UP',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                Expanded(
                  child: Container(
                      height: 460,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(homepageTim),
                              fit: BoxFit.contain))),
                ),
              ],
            );
          } else {
            return Center(child: Text('No data found'));
          }
        });
  }
}

class MobileContainer1 extends StatelessWidget {
  const MobileContainer1({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fetchTableContent('About'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (snapshot.hasData) {
            final List<Map<String, dynamic>> data =
                snapshot.data!.docs.map((DocumentSnapshot document) {
              return document.data() as Map<String, dynamic>;
            }).toList();
            return SingleChildScrollView(
              child: Column(
                children: [
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
                      'About Us',
                      style: AppTheme.getSecondaryTextStyle(30.0),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'See how Whisper can help you in promoting your business',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    data[0]['contentTitle'] ?? '',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    data[0]['description'] ?? '',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ElevatedButton(
                          style: elevatedButtonStyle,
                          onPressed: () {
                            GoRouter.of(context).go('/about');
                          },
                          child: const Text(
                            'SIGN UP',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data found'));
          }
        });
  }
}
