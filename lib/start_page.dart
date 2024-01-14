import 'package:flutter/material.dart';
import 'package:goodproject/login_page.dart';
import 'package:goodproject/signup_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Let's Enjoy Our Best",
                  style: TextStyle(
                      fontFamily: 'Mooli, ',
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Image.asset('image/assets/start.png'),
                ),
                Container(
                  child: const Text(
                      "Authentic food is not just a feast for the palate; it's a journey that whispers the tales of tradition, history, and the timeless artistry of flavors. "),
                ),
                const SizedBox(
                  height: 45,
                ),
                Center(
                  child: Container(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF91AD13)),
                      ),
                      child: const Text(
                        ' SignUp ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Mooli'),
                      ),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF91AD13),
                                ),
                              );
                            });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                            (route) => false);
                      },
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'or',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Center(
                  child: Container(
                      child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFF91AD13),
                        ),
                        backgroundColor: Color(0xFF91AD13)),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF91AD13),
                              ),
                            );
                          });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                    },
                    child: const Text(
                      '  Login  ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Mooli',
                          color: Colors.black),
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
