// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../backend/firebase/fetchTable.dart';
import '../../responsive.dart';
import '../../utils/appTheme_style.dart';
import '../../utils/constants.dart';
import '../../widgets/blurContainer.dart';
import '../../widgets/navBar.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              NavBar(),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Responsive.isDesktop(context) ? w / 10 : w / 20,
                    vertical: 5),
                child: Responsive.isDesktop(context)
                    ? DesktopContainer1()
                    : MobileContainer1(),
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
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchTableNews('Media'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> data = snapshot.data!;
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
                          height: MediaQuery.of(context).size.height,
                          width: w! / 140,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(mediaImg),
                                  fit: BoxFit.fitHeight))),
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
                            Container(
                              height: h!, //MediaQuery.of(context).size.height,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: data.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 20);
                                },
                                itemBuilder: (context, index) {
                                  final DateTime dateTime =
                                      data[index]['createdAt'].toDate();
                                  final formattedDate =
                                      DateFormat('MMMM d, yyyy HH:mm:ss')
                                          .format(dateTime);
                                  return BlurContainer(
                                    width: MediaQuery.sizeOf(context).width,
                                    childColumn: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 200,
                                              width: 150,
                                              child: Center(
                                                child: Image.network(
                                                  data[index]['displayImage'] ??
                                                      '',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(
                                                    formattedDate,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    data[index]
                                                            ['description'] ??
                                                        '',
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          'View',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              Icons
                                                                  .arrow_forward_ios_rounded,
                                                              size: 15,
                                                              color:
                                                                  Colors.white,
                                                            )),
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
    return SingleChildScrollView(
      child: Column(
        children: [
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
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
              return BlurContainer(
                width: MediaQuery.sizeOf(context).width,
                childColumn: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            height: 200,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                    image: AssetImage(beach),
                                    fit: BoxFit.cover))),
                      ),
                      SizedBox(
                        width: 15,
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
                                    color: Colors.white,
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
                                  color: Colors.white,
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
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 15,
                                          color: Colors.white,
                                        )),
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
    );
  }
}
