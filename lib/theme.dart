import 'package:flutter/material.dart';

class CustomTheme {
  static List<Color> fortuneColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.purple,
    Colors.amberAccent,
    Colors.blue,
    Colors.brown,
    Colors.orange
  ];

  static Color mainGreen = const Color.fromARGB(255, 0, 129, 17);
  static Color mainRed = const Color.fromARGB(255, 241, 160, 8);
  static Color mainBlue = Colors.blue;
  static Color mainWhite = Colors.white;
  static Color mainBlack = Color.fromARGB(255, 18, 22, 24);
  static TextStyle titleMedium =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: mainBlack);
  const CustomTheme();

  ThemeData mytheme() {
    return ThemeData(
        textTheme: TextTheme(
            titleMedium: titleMedium,
            titleLarge: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 40, color: mainWhite)),
        // useMaterial3: true,
        fontFamily: 'Quicksand',
        primaryColor: mainBlue,
        colorScheme: ColorScheme.fromSeed(
            shadow: mainBlack,
            outline: mainWhite,
            primary: mainGreen,
            secondary: mainBlue,
            tertiary: mainGreen,
            background: mainRed,
            seedColor: Colors.red));
  }
}
