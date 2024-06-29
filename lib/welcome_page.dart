import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
        padding: const EdgeInsets.all(25),
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
                // const SizedBox(
                //   height: 20,
                // ),
                const Text(
                  'Welcome ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      fontFamily: 'Mooli'),
                ),
                // const Image(
                //   image: AssetImage(
                //     'assets/images/welcome.png',
                //   ),
                // ),
                const SizedBox(
                  height: 90,
                ),
                const Image(
                  image: AssetImage(
                    'assets/images/khajaghar.png',
                  ),
                ),
                const SizedBox(
                  height: 120,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF91AD13),
                          ),
                        );
                      },
                    );
                    FirebaseFirestore
                        .instance //delted the items in the bucket cart
                        .collection('rawOrder')
                        .get()
                        .then((snapshot) {
                      for (DocumentSnapshot doc in snapshot.docs) {
                        doc.reference.delete();
                        print('deleted cart');
                      }
                    });
                    Timer(Duration(seconds: 1), () {
                      Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (conext) => StartPage()),
                          (route) => false);
                    });
                  },
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
