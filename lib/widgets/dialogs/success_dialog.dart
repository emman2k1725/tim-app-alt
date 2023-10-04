import 'package:flutter/material.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';

class SuccessDialog extends StatelessWidget {
  final String title;

  const SuccessDialog({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        children: [
          // showDialog(context: context, builder: (BuildContext context) {  return Center(child: CircularProgressIndicator(),) });
          SizedBox(
            width: 360,
            height: 150,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Success!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      homepageTim, // Replace with your image asset path
                      width: 120,
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
              child: const Icon(Icons.close),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
