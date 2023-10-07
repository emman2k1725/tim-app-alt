// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/backend/firebase/userDataProvider.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/widgets/appbar.dart';

import '../../backend/firebase/fetchTable.dart';
import '../../responsive.dart';
import '../../utils/appTheme_style.dart';
import '../../utils/constants.dart';
import '../../widgets/navBar.dart';
import '../containers/videoplayer.dart';

class HowItWorksPage extends StatefulWidget {
  const HowItWorksPage({super.key});

  @override
  State<HowItWorksPage> createState() => _HowItWorksPageState();
}

class _HowItWorksPageState extends State<HowItWorksPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    UserModel? user = userProvider.userData;
    if (user == null) {
      userProvider.loadDataFromSharedPref();
      user = userProvider.userData;
    }
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
              user?.docID == null ? NavBar() : CustomAppBar(title: 'hs'),
              SizedBox(
                height: 130,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Responsive.isDesktop(context) ? w / 10 : w / 20,
                    vertical: 5),
                child: Responsive.isDesktop(context)
                    ? DesktopContainer1()
                    : Responsive.isTablet(context)
                        ? TabletContainer1()
                        : MobileContainer1(),
              ),
              SizedBox(
                height: 50,
              ),
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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    List<String> dataList = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
      'Item 6',
      'Item 7',
      'Item 8',
      'Item 9',
      'Item 10',
      'Item 11',
      'Item 12',
      // Add more items as needed
    ];

    return StreamBuilder<QuerySnapshot>(
        stream: fetchTableContent('HowItWorks'),
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

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How It Works',
                            style: AppTheme.getSecondaryTextStyle(50.0),
                          ),
                          SizedBox(height: 20),
                          Text(
                            data[0]['contentTitle'] ?? '',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 40),
                          SizedBox(
                            width: w / 4,
                            child: Text(
                              data[0]['description'] ?? '',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          const Divider(
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 100.0),
                          child:
                              SizedBox(height: 350, child: VideoPlayerScreen()),
                        )),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                /*IntrinsicWidth(
              child: Wrap(
                // spacing: 10.0, // Adjust spacing between containers horizontally
                // runSpacing: 10.0, // Adjust spacing between containers vertically
                alignment: WrapAlignment.spaceAround,
                children: List.generate(dataList.length, (index) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Container(
                            height: h / 3,
                            width: w / 5,
                            padding: EdgeInsets.all(5.0),
                            color: Colors.grey.shade300,
                            child: Text(""),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: w / 5,
                            padding: EdgeInsets.all(5.0),
                            color: Colors.grey.shade100,
                            child: Text(
                              "Image\nGraphic Design",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),*/
              ],
            );
          } else {
            return Center(child: Text('No data found'));
          }
        });
  }
}

class TabletContainer1 extends StatelessWidget {
  const TabletContainer1({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    List<String> dataList = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
      'Item 6',
      // Add more items as needed
    ];

    return StreamBuilder<QuerySnapshot>(
        stream: fetchTableContent('HowItWorks'),
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
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: w / 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 350, child: VideoPlayerScreen()),
                  SizedBox(height: 30),
                  Text(
                    'How It Works',
                    textAlign: TextAlign.center,
                    style: AppTheme.getSecondaryTextStyle(30.0),
                  ),
                  SizedBox(height: 20),
                  Text(
                    data[0]['contentTitle'] ?? '',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40),
                  Text(
                    data[0]['description'] ?? '',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  const Divider(
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  /*IntrinsicWidth(
                child: Wrap(
                  // spacing: 10.0, // Adjust spacing between containers horizontally
                  // runSpacing: 10.0, // Adjust spacing between containers vertically
                  alignment: WrapAlignment.spaceAround,
                  children: List.generate(dataList.length, (index) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Container(
                              height: h / 4,
                              width: w / 4,
                              padding: EdgeInsets.all(5.0),
                              color: Colors.grey.shade300,
                              child: Text(""),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: w / 4,
                              padding: EdgeInsets.all(5.0),
                              color: Colors.grey.shade100,
                              child: Text(
                                "Image\nGraphic Design",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),*/
                  /*Wrap(
                spacing: 10.0, // Adjust spacing between containers horizontally
                runSpacing: 10.0, // Adjust spacing between containers vertically
                children: [
                  for (int i = 0; i < dataList.length; i += 2)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: h / 6,
                                width: w / 4,
                                padding: EdgeInsets.all(5.0),
                                color: Colors.grey.shade300,
                                child: Text(""),
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: w / 4,
                                padding: EdgeInsets.all(5.0),
                                color: Colors.grey.shade100,
                                child: Text(
                                  "Image\nGraphic Design",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        if (i + 1 < dataList.length)
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height: h / 6,
                                  width: w / 4,
                                  padding: EdgeInsets.all(5.0),
                                  color: Colors.grey.shade300,
                                  child: Text(""),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  width: w / 4,
                                  padding: EdgeInsets.all(5.0),
                                  color: Colors.grey.shade100,
                                  child: Text(
                                    "Image\nGraphic Design",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),*/
                ],
              ),
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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    List<String> dataList = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
      'Item 6',
      // Add more items as needed
    ];

    return StreamBuilder<QuerySnapshot>(
        stream: fetchTableContent('HowItWorks'),
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
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: w / 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 350, child: VideoPlayerScreen()),
                  SizedBox(height: 30),
                  Text(
                    'How It Works',
                    textAlign: TextAlign.center,
                    style: AppTheme.getSecondaryTextStyle(30.0),
                  ),
                  SizedBox(height: 20),
                  Text(
                    data[0]['contentTitle'] ?? '',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40),
                  Text(
                    data[0]['description'] ?? '',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 20),
                  const Divider(
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  /*ListView.separated(
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: h / 3,
                          width: w / 2,
                          padding: EdgeInsets.all(5.0),
                          color: Colors.grey.shade300,
                          child: Text(""),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: w / 2,
                          padding: EdgeInsets.all(5.0),
                          color: Colors.grey.shade100,
                          child: Text(
                            "Image\nGraphic Design",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  })*/
                  /*Wrap(
                spacing: 10.0, // Adjust spacing between containers horizontally
                runSpacing:
                    double.infinity, // Adjust spacing between containers vertically
                children: [
                  for (int i = 0; i < dataList.length; i++)
                    Column(
                      children: [
                        Container(
                          height: h / 6,
                          width: w / 4,
                          padding: EdgeInsets.all(5.0),
                          color: Colors.grey.shade300,
                          child: Text(""),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: w / 4,
                          padding: EdgeInsets.all(5.0),
                          color: Colors.grey.shade100,
                          child: Text(
                            "Image\nGraphic Design",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                ],
              ),*/
                ],
              ),
            );
          } else {
            return Center(child: Text('No data found'));
          }
        });
  }
}
