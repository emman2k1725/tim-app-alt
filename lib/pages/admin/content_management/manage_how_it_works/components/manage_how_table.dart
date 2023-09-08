import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/pages/admin/content_management/manage_about/components/manage_video.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class ManageHowTable extends StatefulWidget {
  const ManageHowTable({super.key});

  @override
  _ManageHowTableState createState() => _ManageHowTableState();
}

class _ManageHowTableState extends State<ManageHowTable> {
  late int rowsPerPage = 10;
  List<DataRow> dataRows = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnSpacing = screenWidth >= 600 ? 100.0 : 10.0;
    final horizontalMargin = screenWidth > 600 ? 10.0 : 5.0;

    return StreamBuilder<QuerySnapshot>(
      stream: fetchTableContent('About'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        } else if (snapshot.hasData) {
          final List<Map<String, dynamic>> data = snapshot.data!.docs
              .map((QueryDocumentSnapshot document) =>
                  document.data() as Map<String, dynamic>)
              .toList();

          final aboutData = data[0]; // Assuming you want the first document
          return Column(
            children: [
              if (data.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'No data available.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              if (data.isNotEmpty)
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('How It Works',
                                style: AppTextstyle.headerTextStyle),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Title',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Text(aboutData['contentTitle'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(aboutData['description'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            VideoPlayerScreen(
                                videoUrl: aboutData['displayImage']),
                            // VideoPlayer1(videoUrl: aboutData['displayImage'])
                          ],
                        )
                      ],
                    )),
            ],
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }
}
