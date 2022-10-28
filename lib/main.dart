import 'package:flutter/material.dart';
import 'package:up_todo/screens/home_page.dart';
import 'package:up_todo/screens/main_page.dart';
import 'package:up_todo/screens/screen_1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
