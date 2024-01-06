import 'package:flutter/material.dart';
import 'package:goodproject/home_page.dart';
import 'package:goodproject/login_page.dart';
import 'package:goodproject/start_page.dart';
import 'package:goodproject/verifcation_page.dart';
import 'package:goodproject/welcome_page.dart';

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
        initialRoute: 'WelcomePage/',
        routes: {
          'loginpage/': (context) => const LoginPage(),
          'homepage/':(context) => const HomePage(),
          'WelcomePage/': (context) =>const  WelcomePage(),
          'StartPage/' : (context) => const StartPage(),
          'VerifactionPage': (context) => const VerifictionPage(),
        });
  }
}
