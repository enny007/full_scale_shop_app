import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xffffffff),
      primaryColor: Colors.blue,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary: const Color(0xFFE8FDFD),
            brightness: Brightness.light,
          ),
      cardColor: const Color(0xFFF2FDFD),
      canvasColor: Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: const ColorScheme.light(),
          ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF00001a),
      primaryColor: Colors.blue,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary: const Color(0xFF1a1f3c),
            brightness: Brightness.dark,
          ),
      cardColor: const Color(0xFF0a0d2c),
      canvasColor: Colors.black,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: const ColorScheme.dark(),
          ),
    );
  }
}
