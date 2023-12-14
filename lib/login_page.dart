import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pick Up Lines',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.pink,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(9),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Column(
                  children: [
                    Text('Welcome'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      color: Colors.red,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      color: Colors.red,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      color: Colors.red,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      color: Colors.red,
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
