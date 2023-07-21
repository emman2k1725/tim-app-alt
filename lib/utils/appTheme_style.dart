import 'package:flutter/material.dart';

class AppTheme {
  static TextStyle getSecondaryTextStyle(double fontSize) {
    return TextStyle(
      fontFamily: 'Researcher',
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );
  }

  static const TextStyle primaryTextStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 14.0,
    color: Colors.white,
  );

  // Theme(
  // data: ThemeData(
  //   textSelectionTheme: TextSelectionThemeData(
  //     cursorColor: Colors.red, // Set the cursor color
  //   ),
  //   inputDecorationTheme: InputDecorationTheme(
  //     focusedBorder: OutlineInputBorder(
  //       borderSide: BorderSide(color: Colors.blue), // Set the border color when focused
  //     ),
  //     enabledBorder: OutlineInputBorder(
  //       borderSide: BorderSide(color: Colors.grey), // Set the border color when enabled
  //     ),
  //     disabledBorder: OutlineInputBorder(
  //       borderSide: BorderSide(color: Colors.grey), // Set the border color when disabled
  //     ),
  //   ),
  // ),
  // child: TextField(
  //   // TextField properties
  // ),
// )

  static final ThemeData lightTheme = ThemeData(
    // primaryColor: Colors.blue,
    textTheme: TextTheme(
      displayLarge: primaryTextStyle, // Apply the primaryTextStyle to headline1
      bodyLarge: getSecondaryTextStyle(
          60.0), // Apply the secondaryTextStyle to bodyText1
      // You can define more text styles for different elements
    ),
  );
}
