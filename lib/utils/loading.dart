import 'package:flutter/material.dart';

void showCustomLoadingDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 10),
            Text(
              message,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
                letterSpacing: 1.5,
                wordSpacing: 2.0,
              ),
            ),
          ],
        ),
      );
    },
  );
}
