import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/pages/admin/content_management/manage_about/components/manage_video.dart';
import 'package:tim_app/utils/styles.dart';
import 'package:tim_app/widgets/customAddButton.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import 'manage_how_dialog.dart';

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
    return StreamBuilder<QuerySnapshot>(
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
            documentData['docID'] =
                document.id; // Add the document ID to the data map
            return documentData;
          }).toList();

          final aboutData = data[0]; // Assuming you want the first document
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('How It Works', style: AppTextstyle.headerTextStyle),
                    AddButton(
                      buttonText: 'Update How It Works',
                      icon: Icons.update,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              CreateHowDialog(aboutDataUpdate: aboutData),
                        );
                      },
                    ),
                  ],
                ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(aboutData['contentTitle'],
                                style: AppTextstyle.headerTextStyle),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              aboutData['description'],
                              style: AppTextstyle.contentTextStyle,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          children: [
                            VideoPlayerScreen(
                                videoUrl: aboutData['displayImage']),
                          ],
                        ),
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
