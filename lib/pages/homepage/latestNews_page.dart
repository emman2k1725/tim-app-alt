// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../backend/firebase/fetchTable.dart';
import '../../custom_dialog.dart';
import '../../responsive.dart';
import '../../utils/appTheme_style.dart';
import '../../utils/constants.dart';
import '../../widgets/navBar.dart';

class LatestNewsPage extends StatefulWidget {
  const LatestNewsPage({super.key});

  @override
  State<LatestNewsPage> createState() => _LatestNewsPageState();
}

class _LatestNewsPageState extends State<LatestNewsPage> {
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
                    : Responsive.isTablet(context)
                        ? TabletContainer1()
                        : MobileContainer1(),
              ),
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
  int itemsPerPage = 3;
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchTableNews('News'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> data = snapshot.data!;
            final startIndex = (currentPage - 1) * itemsPerPage;
            final endIndex = startIndex + itemsPerPage;
            final paginatedItems =
                data.sublist(startIndex, endIndex.clamp(0, data.length));

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Latest News',
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
                  itemCount: (paginatedItems.length / 3).ceil(),
                  itemBuilder: (context, index) {
                    final startIndex = index * 3;
                    final endIndex = startIndex + 3;
                    final currentPageItems = paginatedItems.sublist(
                        startIndex, endIndex.clamp(0, paginatedItems.length));

                    return Row(
                      children: currentPageItems.map((item) {
                        final DateTime dateTime = item['createdAt'].toDate();
                        final formattedDate =
                            DateFormat('MMMM d, yyyy HH:mm:ss')
                                .format(dateTime);
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 180,
                                  child: Center(
                                    child: item['displayImage'] != null
                                        ? Image.network(
                                            data[index]['displayImage'],
                                            fit: BoxFit.cover,
                                          )
                                        : CircularProgressIndicator(),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  item['contentTitle'] ??
                                      '', //"Nature in numbers",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  formattedDate, //"DEC 21, 2012 | Admin | 2 comments",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  item['description'] ?? '',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    _showRowDialog(data[index], context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Continue reading",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _showRowDialog(
                                                data[index], context);
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 15,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
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
                      onPressed: currentPage * itemsPerPage < data.length
                          ? () => setState(() {
                                currentPage++;
                              })
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

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return StreamBuilder<QuerySnapshot>(
        stream: fetchTableContent('News'),
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

            final startIndex = (currentPage - 1) * itemsPerPage;
            final endIndex = startIndex + itemsPerPage;
            final paginatedItems =
                data.sublist(startIndex, endIndex.clamp(0, data.length));

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Latest News',
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
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. Vestibulum porta libero quis mauris luctus, vel scelerisque ligula vulputate. Aliquam erat volutpat.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
                        final DateTime dateTime = item['createdAt'].toDate();
                        final formattedDate =
                            DateFormat('MMMM d, yyyy HH:mm:ss')
                                .format(dateTime);
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 180,
                                  child: Center(
                                    child: Image.network(
                                      item['displayImage'] ?? '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  item['contentTitle'] ??
                                      '', //"Nature in numbers",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  formattedDate, //"DEC 21, 2012 | Admin | 2 comments",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  item['description'] ?? '',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    _showRowDialog(data[index], context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Continue reading",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _showRowDialog(
                                                data[index], context);
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 15,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
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
                      onPressed: currentPage * itemsPerPage < data.length
                          ? () => setState(() {
                                currentPage++;
                              })
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

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchTableNews('News'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> data = snapshot.data!;
            final startIndex = (currentPage - 1) * itemsPerPage;
            final endIndex = startIndex + itemsPerPage;
            final paginatedItems =
                data.sublist(startIndex, endIndex.clamp(0, data.length));

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Latest News',
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
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. Vestibulum porta libero quis mauris luctus, vel scelerisque ligula vulputate. Aliquam erat volutpat.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
                        final DateTime dateTime = item['createdAt'].toDate();
                        final formattedDate =
                            DateFormat('MMMM d, yyyy HH:mm:ss')
                                .format(dateTime);
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 180,
                                  child: Center(
                                    child: Image.network(
                                      item['displayImage'] ?? '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  item['contentTitle'] ??
                                      '', //"Nature in numbers",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  formattedDate, //"DEC 21, 2012 | Admin | 2 comments",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  item['description'] ?? '',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    _showRowDialog(data[index], context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Continue reading",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _showRowDialog(
                                                data[index], context);
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 15,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
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
                      onPressed: currentPage * itemsPerPage < data.length
                          ? () => setState(() {
                                currentPage++;
                              })
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

void _showRowDialog(Map<String, dynamic> item, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: 'Latest News View',
        message: 'Insert text here',
      );
    },
  );
}
