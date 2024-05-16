import 'package:flutter/material.dart';
import 'package:goodproject/home_page.dart';
import 'package:goodproject/items/Batuk_page.dart';
import 'package:goodproject/items/Chukauni_page.dart';
import 'package:goodproject/items/Phini_page.dart';
import 'package:goodproject/items/Selroti.dart';
import 'package:goodproject/items/cart.dart';
import 'package:goodproject/start_page.dart';
import 'package:goodproject/verifypages/login_page.dart';
import 'package:goodproject/verifypages/reset_page.dart';
import 'package:goodproject/verifypages/signup_page.dart';
import 'package:goodproject/verifypages/verifcation_page.dart';
import 'package:goodproject/welcome_page.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
          'Loginpage/': (context) => const LoginPage(),
          'homepage/': (context) => const HomePage(),
          'WelcomePage/': (context) => const WelcomePage(),
          'StartPage/': (context) => const StartPage(),
          'SignUp/': (context) => const SignUp(),
          'VerifictionPage/': (context) => const VerifictionPage(),
          'ForgotPassword/': (context) => const ForgotPassword(),
          'CartPage/': (context) => const CartPage(),
          'SelRoti/': (context) => const SelRotiPage(),
          'PhiniPage/': (context) => const PhiniPage(),
          'BatukPage/': (context) => const BatukPage(),
          'ChukauniPage/': (context) => const ChukauniPage(),
        });
  }
}
