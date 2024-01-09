import 'package:flutter/material.dart';
import 'package:goodproject/start_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Namaste ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Mooli'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Image(
                  image: AssetImage(
                    'image/assets/welcome.png',
                  ),
                ),
                const SizedBox(
                  height: 300,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StartPage())),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFF91AD13),
                    ),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mooli',
                      color: Colors.black,
                    ),
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
