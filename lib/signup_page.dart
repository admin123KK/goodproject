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
        child: SingleChildScrollView(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Enter your details to signup',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  width: 300,
                  child: Image.asset('image/assets/signup.png'),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 55,
                    width: 400,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter your name",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF91AD13),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF91AD13),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 55,
                    width: 400,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF91AD13)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF91AD13)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 55,
                    width: 400,
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'New password',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Enter your new passowrd',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF91AD13)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF91AD13)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 55,
                    width: 400,
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm  password',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Confirm your Password',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF91AD13)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF91AD13)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    child: ElevatedButton(
                  onPressed: () {},
                  child: Text('SignUp'),
                )),
                SizedBox(
                  height: 6,
                ),
                Container(
                  child: Text('I have account ? '),
                ),
                Container(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFF91AD13)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
