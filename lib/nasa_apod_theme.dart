import 'package:flutter/material.dart';

class NasaApodThemeData {
  static const _appBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
  );

  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: Colors.grey.shade300,
        secondary: Colors.grey.shade100,
      ),
      appBarTheme: _appBarTheme.copyWith(
        iconTheme: const IconThemeData(color: Colors.black),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      colorScheme: ColorScheme.dark(
        primary: Colors.grey.shade800,
        secondary: Colors.grey.shade600,
      ),
      appBarTheme: _appBarTheme.copyWith(
        iconTheme: const IconThemeData(color: Colors.white),
      ),
    );
  }
}
