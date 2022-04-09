import 'package:flutter/material.dart';

class NasaApodThemeData {
  static ThemeData light() {
    return ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.light,
        primary: Colors.grey,
        secondary: Colors.grey,
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.dark,
        primary: Colors.grey.shade800,
        secondary: Colors.grey,
      ),
    );
  }
}
