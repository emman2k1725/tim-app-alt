import 'package:flutter/material.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        children: [
          SizedBox(
            width: 360,
            height: 150,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SUCCESS',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'Operation was successful!',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      homepageTim, // Replace with your image asset path
                      width: 180,
                      height: 150,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.close),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(8),
              ),
            ),
          ),
        ],
      ),
      // actions: [
      //   Row(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       ElevatedButton(
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //         child: Icon(Icons.close),
      //         style: ElevatedButton.styleFrom(
      //           shape: CircleBorder(),
      //           padding: EdgeInsets.all(8),
      //         ),
      //       ),
      //     ],
      //   ),
      // ],
    );
  }
}
