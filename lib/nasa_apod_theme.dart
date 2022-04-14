import 'package:flutter/material.dart';

class NasaApodThemeData {
  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: Colors.grey.shade300,
        secondary: Colors.grey.shade100,
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      colorScheme: ColorScheme.dark(
        primary: Colors.grey.shade800,
        secondary: Colors.grey.shade600,
      ),
    );
  }
}
