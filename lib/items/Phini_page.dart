import 'package:flutter/material.dart';

class PhiniPage extends StatelessWidget {
  const PhiniPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 400,
        width: 300,
        child: Image.asset('assets/images/phini.png'),
      ),
    );
  }
}
