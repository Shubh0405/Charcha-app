import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.lato().fontFamily,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromRGBO(74, 90, 223, 1),
        onPrimary: Colors.white,
        secondary: Color.fromRGBO(25, 59, 83, 0.5),
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.red,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Color.fromRGBO(204, 216, 223, 1),
        onSurface: Colors.black),
    textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 20),
        bodyMedium: TextStyle(fontSize: 15),
        labelLarge: TextStyle(fontSize: 12)),
  );

  static ThemeData darkTheme = lightTheme.copyWith(
      scaffoldBackgroundColor: Color.fromARGB(23, 45, 56, 1),
      colorScheme: lightTheme.colorScheme.copyWith(
          background: const Color.fromRGBO(23, 45, 56, 1),
          onBackground: Colors.white,
          surface: const Color.fromRGBO(61, 84, 95, 0.5),
          onSurface: Colors.white));
}
