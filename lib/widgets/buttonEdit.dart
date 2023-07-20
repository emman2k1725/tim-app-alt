import 'package:flutter/material.dart';

class ReusableEditButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  ReusableEditButton({
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(label),
      icon: Icon(icon),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.grey,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              20.0), // You can adjust the border radius as needed
          side: const BorderSide(color: Colors.blue), // Border color
        ),
      ),
    );
  }
}
