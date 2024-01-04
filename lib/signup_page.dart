import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Create Account ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Enter your details to signup',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Container(
                child: Image.asset('image/assets/signup.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
