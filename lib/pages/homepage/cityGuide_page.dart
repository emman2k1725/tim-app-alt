// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../backend/firebase/fetchTable.dart';
import '../../responsive.dart';
import '../../utils/appTheme_style.dart';
import '../../utils/constants.dart';
import '../../utils/styles.dart';
import '../../widgets/navBar.dart';

class CityGuidePage extends StatefulWidget {
  const CityGuidePage({super.key});

  @override
  State<CityGuidePage> createState() => _CityGuidePageState();
}

class _CityGuidePageState extends State<CityGuidePage> {
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
        future: fetchTableNews('City Guide'),
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

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City Guide',
                        style: AppTheme.getSecondaryTextStyle(50.0),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'PRICING AND TIMELINE',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 40),
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. Vestibulum porta libero quis mauris luctus, vel scelerisque ligula vulputate. Aliquam erat volutpat.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(
                        color: Colors.white,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: (paginatedItems.length / 3).ceil(),
                        itemBuilder: (context, index) {
                          final startIndex = index * 3;
                          final endIndex = startIndex + 3;
                          final currentPageItems = paginatedItems.sublist(
                              startIndex,
                              endIndex.clamp(0, paginatedItems.length));

                          return Row(
                            children: currentPageItems.map((item) {
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: w / (6.5 * 2),
                                        child: ElevatedButton(
                                          style: elevatedButtonSharpBorderStyle,
                                          onPressed: () {},
                                          child: const Text(
                                            'View',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: w / 4.5,
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: h / 3,
                                              child: Center(
                                                child: Image.network(
                                                  item['displayImage'] ?? '',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                  vertical: 0.0),
                                              child: Text(
                                                item['contentTitle'] ?? '',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                  vertical: 0.0),
                                              child: Text(
                                                item['description'] ?? '',
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                      ),
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
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchTableNews('City Guide'),
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

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City Guide',
                        style: AppTheme.getSecondaryTextStyle(50.0),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'PRICING AND TIMELINE',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 40),
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. Vestibulum porta libero quis mauris luctus, vel scelerisque ligula vulputate. Aliquam erat volutpat.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(
                        color: Colors.white,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: (paginatedItems.length / 2).ceil(),
                        itemBuilder: (context, index) {
                          final startIndex = index * 2;
                          final endIndex = startIndex + 2;
                          final currentPageItems = paginatedItems.sublist(
                              startIndex,
                              endIndex.clamp(0, paginatedItems.length));

                          return Row(
                            children: currentPageItems.map((item) {
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: w / 6,
                                        child: ElevatedButton(
                                          style: elevatedButtonSharpBorderStyle,
                                          onPressed: () {},
                                          child: const Text(
                                            'View',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: w / 2.5,
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: h / 3,
                                              child: Center(
                                                child: Image.network(
                                                  item['displayImage'] ?? '',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                  vertical: 0.0),
                                              child: Text(
                                                item['contentTitle'] ?? '',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                  vertical: 0.0),
                                              child: Text(
                                                item['description'] ?? '',
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                      ),
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
        future: fetchTableNews('City Guide'),
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

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City Guide',
                        style: AppTheme.getSecondaryTextStyle(50.0),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'PRICING AND TIMELINE',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 40),
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. Vestibulum porta libero quis mauris luctus, vel scelerisque ligula vulputate. Aliquam erat volutpat.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(
                        color: Colors.white,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: (paginatedItems.length / 1).ceil(),
                        itemBuilder: (context, index) {
                          final startIndex = index * 1;
                          final endIndex = startIndex + 1;
                          final currentPageItems = paginatedItems.sublist(
                              startIndex,
                              endIndex.clamp(0, paginatedItems.length));

                          return Row(
                            children: currentPageItems.map((item) {
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: w / 3,
                                        child: ElevatedButton(
                                          style: elevatedButtonSharpBorderStyle,
                                          onPressed: () {},
                                          child: const Text(
                                            'View',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: h / 3,
                                              child: Center(
                                                child: Image.network(
                                                  item['displayImage'] ?? '',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                  vertical: 0.0),
                                              child: Text(
                                                item['contentTitle'] ?? '',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                  vertical: 0.0),
                                              child: Text(
                                                item['description'] ?? '',
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                      ),
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
