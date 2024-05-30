import 'package:flutter/material.dart';
import 'package:goodproject/app_localization.dart';
import 'package:goodproject/langugages_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final languageProvider =
        Provider.of<LanguageProvider>(context); // Access LanguageProvider

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                AppLocalizations.of(context).translate(
                  'changeLanguage',
                ),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: DropdownButton<Locale>(
                value: languageProvider.locale,
                onChanged: (Locale? newLocale) {
                  if (newLocale != null) {
                    languageProvider.setLocale(newLocale);
                  }
                },
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: Locale('en'),
                  ),
                  DropdownMenuItem(
                    child: Text('नेपाली'),
                    value: Locale('ne'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
