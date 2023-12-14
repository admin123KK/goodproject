import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

appBar: AppBar(title: const Text('Pick Up Lines',style: TextStyle(color: Colors.white,),),
backgroundColor: Colors.pink,
centerTitle: true,
),
backgroundColor: Colors.white,
body: Center(child: Text('We are Nepali'),),
    );
  }
}
