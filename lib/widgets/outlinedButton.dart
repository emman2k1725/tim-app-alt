import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class ShadowButton extends StatefulWidget {
  const ShadowButton({super.key});

  @override
  State<ShadowButton> createState() => _ShadowButtonState();
}

class _ShadowButtonState extends State<ShadowButton> {
  bool isPressed = false;
  Color shadowColor = Colors.blueAccent.shade700;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Listener(
        onPointerDown: (event) => setState(() {
          isPressed = true;
        }),
        onPointerUp: (event) => setState(() {
          isPressed = false;
        }),
        child: Container(
          width: 200.0,
          height: 50.0,
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
              ]),
          child: TextButton(
            onHover: (hovered) => setState(() {
              isPressed = hovered;
            }),
            style: TextButton.styleFrom(
                side: const BorderSide(color: Colors.white70, width: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.favorite),
                const SizedBox(
                    height:
                        8.0), // Adjust the spacing between the icon and text
                Text(
                  'How It Works',
                  style: TextStyle(color: Colors.white, shadows: [
                    for (double i = 1; i < (isPressed ? 8 : 4); i++)
                      Shadow(
                        color: shadowColor,
                        blurRadius: 3 * i,
                      )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
