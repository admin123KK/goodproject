import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:goodproject/app_localization.dart';
import 'package:goodproject/verifypages/login_page.dart';
import 'package:provider/provider.dart';

import 'langugages_provider.dart';
import 'verifypages/signup_page.dart'; // Import Provider

class StartPage extends StatefulWidget {
  const StartPage({Key? key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });
      super.initState();
    }

    final languageProvider =
        Provider.of<LanguageProvider>(context); // Access LanguageProvider

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .translate('title'), // Access AppLocalizations directly
                  style: const TextStyle(
                    fontFamily: 'Mooli',
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: Image.asset('assets/images/start.png'),
                ),
                Container(
                  child: Text(
                    AppLocalizations.of(context).translate(
                        'description'), // Access AppLocalizations directly
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 45),
                Center(
                  child: Container(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF91AD13)),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.translate(
                            'signup'), // Access AppLocalizations directly
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Mooli',
                        ),
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: Color(0xFF91AD13)),
                            );
                          },
                        );
                        Timer(Duration(seconds: 1), () {
                          Navigator.of(context).pop();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()),
                            (route) => false,
                          );
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('or'), // Access AppLocalizations directly
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF91AD13)),
                        backgroundColor: Color(0xFF91AD13),
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: Color(0xFF91AD13)),
                            );
                          },
                        );
                        Timer(Duration(seconds: 1), () {
                          Navigator.of(context).pop();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false,
                          );
                        });
                      },
                      child: Text(
                        AppLocalizations.of(context)!.translate(
                            'login'), // Access AppLocalizations directly
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Mooli',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 108),
                Center(
                  child: DropdownButton<Locale>(
                    value: languageProvider
                        .locale, // Use the locale from LanguageProvider
                    onChanged: (Locale? newLocale) {
                      if (newLocale != null) {
                        languageProvider.setLocale(
                            newLocale); // Update the locale using LanguageProvider
                      }
                    },
                    items: const [
                      DropdownMenuItem(
                        value: Locale('en'),
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: Locale('ne'),
                        child: Text('नेपाली'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
