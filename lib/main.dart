import 'package:flutter/material.dart';
import 'package:goodproject/cricket_page.dart';
import 'package:goodproject/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aakash App',
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        initialRoute: 'loginpage/',
        routes: {
          'loginpage/': (context) => const LoginPage(),
          'CricketPage/': (context) => CricketPage()
        });
  }
}
