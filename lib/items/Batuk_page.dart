import 'package:flutter/material.dart';

class BatukPage extends StatelessWidget {
  const BatukPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 400,
        width: 300,
        child: Image.asset('assets/images/selroti.png'),
      ),
    );
  }
}
