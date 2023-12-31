// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/widgets/appbar.dart';
import '../../ads_footer.dart';
import '../../backend/firebase/fetchTable.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/backend/firebase/userDataProvider.dart';
import 'package:tim_app/model/UserModel.dart';
import '../../custom_dialog.dart';
import '../../navBarProvider.dart';
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
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Responsive.isDesktop(context) ? w / 10 : w / 20,
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
        stream: fetchTableContent('Media'),
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
                        child: SizedBox(
                          height: h!,
                          child: SingleChildScrollView(
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
                                  height: 10,
                                ),
                                ListView.separated(
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
                                                  child: data[index][
                                                              'displayImage'] !=
                                                          null
                                                      ? Image.network(
                                                          data[index]
                                                              ['displayImage'],
                                                          fit: BoxFit.cover,
                                                        )
                                                      : CircularProgressIndicator(),
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
                                                      CrossAxisAlignment
                                                          .stretch,
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
                                                      child: InkWell(
                                                        onTap: () {
                                                          _showRowDialog(
                                                              data[index],
                                                              context);
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              'View',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  _showRowDialog(
                                                                      data[
                                                                          index],
                                                                      context);
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .arrow_forward_ios_rounded,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                          ],
                                                        ),
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
    return StreamBuilder<QuerySnapshot>(
        stream: fetchTableContent('Media'),
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
                    itemCount: data.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20);
                    },
                    itemBuilder: (context, index) {
                      final DateTime dateTime =
                          data[index]['createdAt'].toDate();
                      final formattedDate =
                          DateFormat('MMMM d, yyyy HH:mm:ss').format(dateTime);
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
                                  child: Center(
                                    child: Image.network(
                                      data[index]['displayImage'] ?? '',
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
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        formattedDate,
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
                                        data[index]['description'] ?? '',
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
                                        child: InkWell(
                                          onTap: () {
                                            _showRowDialog(
                                                data[index], context);
                                          },
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
                                                  onPressed: () {
                                                    _showRowDialog(
                                                        data[index], context);
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 15,
                                                    color: Colors.white,
                                                  )),
                                            ],
                                          ),
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
          } else {
            return Center(child: Text('No data found'));
          }
        });
  }
}

void _showRowDialog(Map<String, dynamic> item, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: 'Media View',
        message: 'Insert text here',
      );
    },
  );
}
