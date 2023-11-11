import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/widgets/blurContainer.dart';

class TransactionView extends StatefulWidget {
  final Map<String, dynamic> item;
  const TransactionView({super.key, required this.item});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: fetchTransaction('advertisement', widget.item['docID']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        } else if (snapshot.hasData) {
          final data = snapshot.data;
          return data!.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'No data available.',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      // Use the 'item' map to display data.
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlurContainer(
                            width: double.maxFinite,
                            height: 100,
                            childColumn: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item[
                                        'title'], // Replace with your name or text
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Chip(
                                    label: Text(
                                      item['status'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins',
                                          fontSize: 14),
                                    ),
                                    backgroundColor:
                                        item['status'] == 'Approved'
                                            ? Colors.green.shade200
                                            : Colors.lightBlue.shade200,
                                    elevation: 4,
                                    shadowColor: Colors.blue[400],
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['placement'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                              // You can customize the ListTile as needed.
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }
}
