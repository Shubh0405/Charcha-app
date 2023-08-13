import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.lato().fontFamily,
    scaffoldBackgroundColor: Colors.white,
    shadowColor: Color.fromARGB(255, 201, 198, 198),
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromRGBO(74, 90, 223, 1),
        onPrimary: Colors.white,
        primaryContainer: Color.fromRGBO(138, 148, 236, 1),
        secondary: Color.fromRGBO(25, 59, 83, 0.5),
        onSecondary: Color.fromRGBO(204, 216, 223, 0.5),
        error: Colors.red,
        onError: Colors.red,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Color.fromRGBO(217, 222, 224, 1),
        surfaceVariant: Color.fromRGBO(190, 194, 194, 1),
        onSurface: Colors.black,
        onSurfaceVariant: Colors.black54),
    textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 20),
        bodyMedium: TextStyle(fontSize: 15),
        bodySmall: TextStyle(fontSize: 12)),
  );

  static ThemeData darkTheme = lightTheme.copyWith(
      scaffoldBackgroundColor: Colors.black,
      colorScheme: lightTheme.colorScheme.copyWith(
          background: const Color.fromRGBO(23, 45, 56, 1),
          onBackground: Colors.white,
          surface: const Color.fromRGBO(61, 84, 95, 0.5),
          surfaceVariant: Color.fromARGB(125, 130, 146, 153),
          onSurface: Colors.white,
          onSurfaceVariant: Colors.white54));
}
