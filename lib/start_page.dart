import 'package:flutter/material.dart';
import 'package:goodproject/signup_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
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
                  onPressed: () {},
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
    );
  }
}
