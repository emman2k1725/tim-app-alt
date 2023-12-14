import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  GradientButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: const BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey[300]!,
          //     spreadRadius: 2,
          //     blurRadius: 10,
          //     offset: Offset(0, 3),
          //   ),
          // ],
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 25, 124, 211),
              Color.fromARGB(255, 220, 87, 154),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 45.0),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
