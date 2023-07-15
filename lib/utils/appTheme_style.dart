import 'package:flutter/material.dart';

class AppTheme {
  static TextStyle getSecondaryTextStyle(double fontSize) {
    return TextStyle(
      fontFamily: 'Researcher',
      fontWeight: FontWeight.w700,
      fontSize: fontSize,
      color: Colors.white,
    );
  }

  static const TextStyle primaryTextStyle = TextStyle(
    fontFamily: 'SecondaryFont',
    fontSize: 14.0,
    color: Colors.grey,
  );

  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    hintColor: Colors.green,
    textTheme: TextTheme(
      displayLarge: primaryTextStyle, // Apply the primaryTextStyle to headline1
      bodyLarge: getSecondaryTextStyle(
          60.0), // Apply the secondaryTextStyle to bodyText1
      // You can define more text styles for different elements
    ),
  );
}
