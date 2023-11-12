// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/pages/containers/container1.dart';
import 'package:tim_app/pages/homepage/videoHome.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/pages/containers/imagecarousel.dart';
import 'package:tim_app/widgets/navBar.dart';

import '../../ads_footer.dart';
import '../../responsive.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        body: StreamBuilder<QuerySnapshot>(
            stream: fetchTableContent('HowItWorks'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching data'));
              } else if (snapshot.hasData) {
                final List<Map<String, dynamic>> data =
                    snapshot.data!.docs.map((QueryDocumentSnapshot document) {
                  Map<String, dynamic> documentData =
                      document.data() as Map<String, dynamic>;
                  documentData['id'] =
                      document.id; // Add the document ID to the data map
                  return documentData;
                }).toList();

                final aboutData = data[0];
                return Stack(
                  children: <Widget>[
                    SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          child: VideoHomePlayer(
                            videoUrl: aboutData['displayImage'],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black54,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          const Container1(),
                          const SizedBox(
                            height: 40,
                          ),
                          ImageCarousel(),
                          const SizedBox(
                            height: 20,
                          ),
                          AdsFooter(),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('No data found'));
              }
            }));
  }
}
