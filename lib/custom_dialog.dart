// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;

  CustomAlertDialog({
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          label: Text('Back'),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, padding: EdgeInsets.all(15)),
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 400,
              height: 140,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          message,
                          textAlign: TextAlign.left,
                          softWrap: true,
                          // Other text style properties can be added here
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
