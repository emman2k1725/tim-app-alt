import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String buttonText;
  final IconData icon;
  final VoidCallback onPressed;

  const AddButton({
    super.key,
    required this.buttonText,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      label: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
