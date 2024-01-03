import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome ',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'Mooli')
            ),
          ],
        ),
      ),
    );
  }
}
