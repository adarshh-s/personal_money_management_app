import 'package:flutter/material.dart';
import 'package:personal_money_managment_app/home/screen_home.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 12, 252, 20))),
      home: ScreenHome(),
    );
  }
}
