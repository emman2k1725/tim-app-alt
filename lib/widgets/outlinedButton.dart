import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

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
        width: 200.0,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            for (double i = 1; i < 5; i++)
              BoxShadow(
                color: shadowColor,
                blurRadius: (isPressed ? 5 : 3) * i,
                inset: true,
              ),
            for (double i = 1; i < 5; i++)
              BoxShadow(
                spreadRadius: -1,
                color: shadowColor,
                blurRadius: (isPressed ? 5 : 3) * i,
                blurStyle: BlurStyle.outer,
              )
          ],
        ),
        child: TextButton(
          onHover: (hovered) => setState(() {
            isPressed = hovered;
          }),
          style: TextButton.styleFrom(
            side: const BorderSide(color: Colors.white54, width: 2),
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
              ),
              const SizedBox(
                height: 8.0,
              ), // Adjust the spacing between the icon and text
              Text(
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  shadows: [
                    for (double i = 1; i < (isPressed ? 8 : 4); i++)
                      Shadow(
                        color: shadowColor,
                        blurRadius: 3 * i,
                      )
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
