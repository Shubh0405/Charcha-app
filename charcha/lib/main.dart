import 'package:charcha/screen/home_page.dart';
import 'package:charcha/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.light,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        home: const HomePage());
  }
}
