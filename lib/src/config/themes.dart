import 'package:flutter/material.dart';
import 'package:flutter_english/src/utils/constants/nums.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black,
      splashColor: Colors.transparent,
      fontFamily: 'IBM',
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: textSize),
      ),
    );
  }
}
