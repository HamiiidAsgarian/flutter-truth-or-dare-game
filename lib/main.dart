import 'package:flutter/material.dart';
import 'package:mafia/screens/home_screen.dart';
import 'package:mafia/theme.dart';
// ignore: unused_import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: const CustomTheme().mytheme(),
        home: const HomeScreen());
  }
}
