import 'package:flutter/material.dart';

// Clase para configurar el tema de la aplicacion
class AppTheme {
  static const primaryColor = Color.fromARGB(255, 0, 177, 231);
  static const detailColor = Color.fromARGB(255, 200, 211, 231);
  static const scaffoldBackgroundColor = Color.fromARGB(255, 32, 113, 138);
  static const scaffoldBackgroundColorLight =
      Color.fromARGB(255, 200, 211, 231);
  static const textColor = Colors.white;
  static const textColorDark = Colors.black;

  final ThemeData _appTheme = ThemeData(
    fontFamily: 'Inter',
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(),
    ).apply(
      bodyColor: textColor,
    ),
  );

  AppTheme();

  ThemeData getTheme() {
    return _appTheme;
  }
}
