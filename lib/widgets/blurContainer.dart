import 'package:flutter/material.dart';
import 'dart:ui';

class BlurImageContainer extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final IconData icon;

  const BlurImageContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                for (double i = 1; i < 5; i++)
                  const BoxShadow(
                    spreadRadius: -1,
                    color: Colors.blueAccent,
                    blurRadius: 1,
                    blurStyle: BlurStyle.outer,
                  )
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white60.withOpacity(0.10),
                  Colors.blue.withOpacity(0.10),
                ],
              ),
              // color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(width: 2, color: Colors.white10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BlurContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget childColumn;

  const BlurContainer(
      {Key? key, this.height, this.width, required this.childColumn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                for (double i = 1; i < 5; i++)
                  const BoxShadow(
                    spreadRadius: -1,
                    color: Colors.blueAccent,
                    blurRadius: 1,
                    blurStyle: BlurStyle.outer,
                  )
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white60.withOpacity(0.10),
                  Colors.blue.withOpacity(0.10),
                ],
              ),
              // color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(width: 2, color: Colors.white10),
            ),
            child: childColumn,
          ),
        ),
      ),
    );
  }
}
