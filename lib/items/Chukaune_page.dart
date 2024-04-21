import 'package:flutter/material.dart';

class ChukauniPage extends StatelessWidget {
  const ChukauniPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 400,
        width: 300,
        child: Image.asset('assets/images/chukauni.png'),
      ),
    );
  }
}
