import 'package:flutter/material.dart';

class OutlinedButtonContainer extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const OutlinedButtonContainer({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.transparent,
      ),
      child: FractionallySizedBox(
        widthFactor: 1.0,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            side: BorderSide(color: Colors.blue),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            textStyle: TextStyle(fontSize: 16.0),
          ),
          child: Text(buttonText),
        ),
      ),
    );
  }
}
