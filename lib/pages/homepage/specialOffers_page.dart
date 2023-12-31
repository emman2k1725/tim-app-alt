// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/backend/firebase/userDataProvider.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/widgets/appbar.dart';

import '../../backend/firebase/fetchTable.dart';
import '../../custom_dialog.dart';
import '../../responsive.dart';
import '../../utils/appTheme_style.dart';
import '../../utils/constants.dart';
import '../../widgets/navBar.dart';

class SpecialOffersPage extends StatefulWidget {
  const SpecialOffersPage({super.key});

  @override
  State<SpecialOffersPage> createState() => _SpecialOffersPageState();
}

class _SpecialOffersPageState extends State<SpecialOffersPage> {
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DesktopContainer1 extends StatefulWidget {
  const DesktopContainer1({super.key});

  @override
  State<DesktopContainer1> createState() => _DesktopContainer1State();
}

class _DesktopContainer1State extends State<DesktopContainer1> {
  int itemsPerPage = 2;
  int currentPage = 1;

  List<Map<String, dynamic>> data = [];

  List<Map<String, dynamic>> get paginatedItems {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return data.sublist(startIndex, endIndex.clamp(0, data.length));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('special_offers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (snapshot.hasData) {
            data = snapshot.data!.docs.map((DocumentSnapshot document) {
              return document.data() as Map<String, dynamic>;
            }).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Special Offer',
                    style: AppTheme.getSecondaryTextStyle(50.0),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'PRICING AND TIMELINE',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: w / 2,
                  child: const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. Vestibulum porta libero quis mauris luctus, vel scelerisque ligula vulputate. Aliquam erat volutpat.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: (paginatedItems.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    final startIndex = index * 2;
                    final endIndex = startIndex + 2;
                    final currentPageItems = paginatedItems.sublist(
                        startIndex, endIndex.clamp(0, paginatedItems.length));

                    return Row(
                      children: currentPageItems.map((item) {
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: h / 2.5,
                                    child: Center(
                                      child: Image.network(
                                        item['imageURL'] ?? '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: h / 2.5,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 15),
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              item['offerCode'] ?? '',
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              item['description'] ?? '',
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Spacer(),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: SizedBox(
                                              width: 250,
                                              child: InkWell(
                                                onTap: () {
                                                  _showRowDialog('', context);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      'View',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          _showRowDialog(
                                                              '', context);
                                                        },
                                                        icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            color: Colors.black,
                                                            size: 15)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: currentPage > 1
                          ? () => setState(() => currentPage--)
                          : null,
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: paginatedItems.length == itemsPerPage
                          ? () => setState(() => currentPage++)
                          : null,
                      child: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(child: Text('No data found'));
          }
        });
  }
}

class TabletContainer1 extends StatefulWidget {
  const TabletContainer1({super.key});

  @override
  State<TabletContainer1> createState() => _TabletContainer1State();
}

class _TabletContainer1State extends State<TabletContainer1> {
  int itemsPerPage = 2;
  int currentPage = 1;

  List<Map<String, dynamic>> data = [];

  List<Map<String, dynamic>> get paginatedItems {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return data.sublist(startIndex, endIndex.clamp(0, data.length));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('special_offers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (snapshot.hasData) {
            data = snapshot.data!.docs.map((DocumentSnapshot document) {
              return document.data() as Map<String, dynamic>;
            }).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Special Offer',
                  style: AppTheme.getSecondaryTextStyle(50.0),
                ),
                SizedBox(height: 10),
                Text(
                  'PRICING AND TIMELINE',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: w / 1,
                  child: const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. Vestibulum porta libero quis mauris luctus, vel scelerisque ligula vulputate. Aliquam erat volutpat.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: (paginatedItems.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    final startIndex = index * 2;
                    final endIndex = startIndex + 2;
                    final currentPageItems = paginatedItems.sublist(
                        startIndex, endIndex.clamp(0, paginatedItems.length));

                    return Row(
                      children: currentPageItems.map((item) {
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: h / 2.5,
                                    child: Center(
                                      child: Image.network(
                                        item['imageURL'] ?? '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: h / 2.5,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 15),
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              item['offerCode'] ?? '',
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              item['description'] ?? '',
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Spacer(),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: SizedBox(
                                              width: 250,
                                              child: InkWell(
                                                onTap: () {
                                                  _showRowDialog('', context);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      'View',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          _showRowDialog(
                                                              '', context);
                                                        },
                                                        icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            color: Colors.black,
                                                            size: 15)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: currentPage > 1
                          ? () => setState(() => currentPage--)
                          : null,
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: paginatedItems.length == itemsPerPage
                          ? () => setState(() => currentPage++)
                          : null,
                      child: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(child: Text('No data found'));
          }
        });
  }
}

class MobileContainer1 extends StatefulWidget {
  const MobileContainer1({super.key});

  @override
  State<MobileContainer1> createState() => _MobileContainer1State();
}

class _MobileContainer1State extends State<MobileContainer1> {
  int itemsPerPage = 1;
  int currentPage = 1;

  List<Map<String, dynamic>> data = [];

  List<Map<String, dynamic>> get paginatedItems {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return data.sublist(startIndex, endIndex.clamp(0, data.length));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('special_offers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (snapshot.hasData) {
            data = snapshot.data!.docs.map((DocumentSnapshot document) {
              return document.data() as Map<String, dynamic>;
            }).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Special Offer',
                  style: AppTheme.getSecondaryTextStyle(30.0),
                ),
                SizedBox(height: 10),
                Text(
                  'PRICING AND TIMELINE',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: w / 1,
                  child: const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. Vestibulum porta libero quis mauris luctus, vel scelerisque ligula vulputate. Aliquam erat volutpat.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: (paginatedItems.length / 1).ceil(),
                  itemBuilder: (context, index) {
                    final startIndex = index * 1;
                    final endIndex = startIndex + 1;
                    final currentPageItems = paginatedItems.sublist(
                        startIndex, endIndex.clamp(0, paginatedItems.length));

                    return Row(
                      children: currentPageItems.map((item) {
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: h / 2.5,
                                    child: Center(
                                      child: Image.network(
                                        item['imageURL'] ?? '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: h / 2.5,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 15),
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              item['offerCode'] ?? '',
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              item['description'] ?? '',
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Spacer(),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: SizedBox(
                                              width: 250,
                                              child: InkWell(
                                                onTap: () {
                                                  _showRowDialog('', context);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      'View',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          _showRowDialog(
                                                              '', context);
                                                        },
                                                        icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            color: Colors.black,
                                                            size: 15)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: currentPage > 1
                          ? () => setState(() => currentPage--)
                          : null,
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: paginatedItems.length == itemsPerPage
                          ? () => setState(() => currentPage++)
                          : null,
                      child: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(child: Text('No data found'));
          }
        });
  }
}

void _showRowDialog(
    /*Map<String, dynamic> item*/ String item, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: 'Special Offer View',
        message: 'Insert text here',
      );
    },
  );
}
