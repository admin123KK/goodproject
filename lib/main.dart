import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:goodproject/app_localization.dart';
import 'package:goodproject/firebase_options.dart';
import 'package:goodproject/home_page.dart';
import 'package:goodproject/items/Batuk_page.dart';
import 'package:goodproject/items/Chukauni_page.dart';
import 'package:goodproject/items/Phini_page.dart';
import 'package:goodproject/items/Selroti.dart';
import 'package:goodproject/items/cart.dart';
import 'package:goodproject/items/notification_page.dart';
import 'package:goodproject/langugages_provider.dart';
import 'package:goodproject/start_page.dart';
import 'package:goodproject/verifypages/login_page.dart';
import 'package:goodproject/verifypages/reset_page.dart';
import 'package:goodproject/verifypages/signup_page.dart';
import 'package:goodproject/verifypages/verifcation_page.dart';
import 'package:goodproject/welcome_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'Khaja_App',
          channelName: 'KhajaGhar',
          channelDescription: 'Food Delivery Application',
        ),
      ],
      debug: true);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => LanguageProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
        locale: languageProvider.locale,
        supportedLocales: [
         Locale('en'),
          Locale('ne'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
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
          'NotficationPage/': (context) => const NotificationPage()
        });
  }
}
