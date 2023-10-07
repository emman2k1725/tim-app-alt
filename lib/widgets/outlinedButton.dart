// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../responsive.dart';

class ShadowButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const ShadowButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<ShadowButton> createState() => _ShadowButtonState();
}

class _ShadowButtonState extends State<ShadowButton> {
  bool isPressed = false;
  Color shadowColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) => setState(() {
        isPressed = true;
      }),
      onPointerUp: (event) => setState(() {
        isPressed = false;
      }),
      child: Container(
        width: Responsive.isDesktop(context) ? 200.0 : 170.0,
        height: Responsive.isDesktop(context) ? 100.0 : 90.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),

          // boxShadow: [
          //   for (double i = 1; i < 5; i++)
          //     BoxShadow(
          //       color: shadowColor,
          //       blurRadius: (isPressed ? 5 : 3) * i,
          //       inset: true,
          //     ),
          //   for (double i = 1; i < 5; i++)
          //     BoxShadow(
          //       spreadRadius: -1,
          //       color: shadowColor,
          //       blurRadius: (isPressed ? 5 : 3) * i,
          //       blurStyle: BlurStyle.outer,
          //     )
          // ],
        ),
        child: TextButton(
          onHover: (hovered) => setState(() {
            isPressed = hovered;
          }),
          style: TextButton.styleFrom(
            side: BorderSide(color: shadowColor, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: widget.onPressed,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: Colors.white70,
                shadows: [
                  for (double i = 1; i < (isPressed ? 8 : 4); i++)
                    Shadow(
                      color: shadowColor,
                      blurRadius: 3 * i,
                    )
                ],
              ),
              const SizedBox(
                height: 8.0,
              ), // Adjust the spacing between the icon and text
              Text(
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Responsive.isDesktop(context) ? 24.0 : 18.0,
                  shadows: [
                    for (double i = 1; i < (isPressed ? 8 : 4); i++)
                      Shadow(
                        color: shadowColor,
                        blurRadius: 3 * i,
                      )
                    // Shadow(
                    //   color: shadowColor, // Choose the color of the shadow
                    //   blurRadius:
                    //       8.0, // Adjust the blur radius for the shadow effect
                    //   offset: Offset(0.0,
                    //       0.0), // Set the horizontal and vertical offset for the shadow
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
