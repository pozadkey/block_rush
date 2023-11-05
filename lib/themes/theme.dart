import 'package:flutter/material.dart';

// Default app theme
ThemeData theme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
  colorScheme: ColorScheme.dark(
      background: Colors.black,
      primary: Colors.grey[900]!,
      secondary: Colors.grey[800]!),

  // Text Theme
  textTheme: const TextTheme(
    // Header text style
    displayLarge: TextStyle(
        fontSize: 54,
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'ClashDisplay',
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2),

  ),
);

