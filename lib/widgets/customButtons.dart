import 'package:flutter/material.dart';
import 'package:tim_app/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      height: 40,
      width: 150,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          backgroundColor: AppColors.primary,
        ),
        child: Text(text),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomIconButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        height: 40,
        width: 150,
        child: ElevatedButton(
          onPressed: onPressed,

          child: Text(text), // Replace 'Button' with the desired label text
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            backgroundColor: AppColors.primary,
          ),
        ));
  }
}
