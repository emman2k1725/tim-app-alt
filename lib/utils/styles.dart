import 'package:flutter/material.dart';
import 'package:tim_app/utils/colors.dart';

TextStyle navTextStyle = const TextStyle(
  fontFamily: 'Poppins', // Specify the font family
  fontSize: 16.0, // Specify the font size
  fontWeight: FontWeight
      .normal, // Specify the font weight (e.g., FontWeight.bold for bold text)
  fontStyle: FontStyle
      .normal, // Specify the font style (e.g., FontStyle.italic for italic text)
  letterSpacing: 1.2, // Specify the letter spacing
  color: Colors.white, // Specify the text color
  // You can also include other properties like decoration, decorationColor, etc.
);

ButtonStyle borderedButtonStyle = ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.all(Colors.white),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      side: BorderSide(color: AppColors.primary),
      borderRadius: BorderRadius.circular(20),
    )));

ButtonStyle elevatedButtonStyle = ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.all(AppColors.primary),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    )));

ButtonStyle elevatedButtonSharpBorderStyle = ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.all(AppColors.primary),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
    )));

class AppTextstyle {
  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );

  static const TextStyle contentTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    letterSpacing: 1.2,
    height: 1.5,
  );

  static const TextStyle linkTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );
}
