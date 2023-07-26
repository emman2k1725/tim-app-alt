// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

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
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.teal,
    Colors.pink,
    Colors.cyan,
  ];

  int itemsPerPage = 3;
  int currentPage = 1;

  List<Color> get paginatedItems {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return colors.sublist(startIndex, endIndex.clamp(0, colors.length));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

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
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
                return Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 180,
                          color: item,
                          child: Center(
                            child: Text(
                              "News Images",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Nature in numbers",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "DEC 21, 2012 | Admin | 2 comments",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. ",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        Row(
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
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 15,
                                  color: Colors.white,
                                )),
                          ],
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
              onPressed:
                  currentPage > 1 ? () => setState(() => currentPage--) : null,
              child: Icon(Icons.arrow_back),
            ),
            SizedBox(width: 16),
            ElevatedButton(
              onPressed: currentPage * itemsPerPage < colors.length
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
  }
}

class TabletContainer1 extends StatefulWidget {
  const TabletContainer1({super.key});

  @override
  State<TabletContainer1> createState() => _TabletContainer1State();
}

class _TabletContainer1State extends State<TabletContainer1> {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.teal,
    Colors.pink,
    Colors.cyan,
  ];

  int itemsPerPage = 2;
  int currentPage = 1;

  List<Color> get paginatedItems {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return colors.sublist(startIndex, endIndex.clamp(0, colors.length));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

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
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 180,
                          color: item,
                          child: Center(
                            child: Text(
                              "News Images",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Nature in numbers",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "DEC 21, 2012 | Admin | 2 comments",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. ",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        Row(
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
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 15,
                                  color: Colors.white,
                                )),
                          ],
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
              onPressed:
                  currentPage > 1 ? () => setState(() => currentPage--) : null,
              child: Icon(Icons.arrow_back),
            ),
            SizedBox(width: 16),
            ElevatedButton(
              onPressed: currentPage * itemsPerPage < colors.length
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
  }
}

class MobileContainer1 extends StatefulWidget {
  const MobileContainer1({super.key});

  @override
  State<MobileContainer1> createState() => _MobileContainer1State();
}

class _MobileContainer1State extends State<MobileContainer1> {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.teal,
    Colors.pink,
    Colors.cyan,
  ];

  int itemsPerPage = 1;
  int currentPage = 1;

  List<Color> get paginatedItems {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return colors.sublist(startIndex, endIndex.clamp(0, colors.length));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Latest News',
          style: AppTheme.getSecondaryTextStyle(30.0),
        ),
        SizedBox(height: 10),
        Text(
          'PRICING AND TIMELINE',
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
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
          itemCount: paginatedItems.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 180,
                          color: paginatedItems[index],
                          child: Center(
                            child: Text(
                              "News Images",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Nature in numbers",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "DEC 21, 2012 | Admin | 2 comments",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur molestie, odio sed feugiat interdum, nisl lectus sagittis odio, vel volutpat lectus elit in massa. ",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        Row(
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
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 15,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed:
                  currentPage > 1 ? () => setState(() => currentPage--) : null,
              child: Icon(Icons.arrow_back),
            ),
            SizedBox(width: 16),
            ElevatedButton(
              onPressed: currentPage * itemsPerPage < colors.length
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
  }
}
