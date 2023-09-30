// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final bool showContinueButton;

  CustomAlertDialog({
    required this.title,
    required this.message,
    this.showContinueButton = false,
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
                  Visibility(
                      visible: showContinueButton == true, child: Spacer()),
                  Visibility(
                    visible: showContinueButton == true,
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Continue reading",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
