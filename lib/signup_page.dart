import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _paswordController = TextEditingController();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  height: 260,
                  width: 400,
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
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: " Enter your name",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.person_2_outlined),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your name";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 55,
                    width: 400,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
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
                      obscureText: passToggle,
                      controller: _paswordController,
                      decoration: InputDecoration(
                        labelText: 'New password',
                        prefixIcon: const Icon(Icons.lock_outlined),
                        labelStyle: const TextStyle(color: Colors.black),
                        hintText: 'Enter your new passowrd',
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              passToggle = !passToggle;
                            });
                          },
                          child: Icon(passToggle
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF91AD13)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            )),
                        enabledBorder: const OutlineInputBorder(
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
                      obscureText: passToggle,
                      controller: _paswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm  password',
                        labelStyle: const TextStyle(color: Colors.black),
                        hintText: 'Confirm your Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              passToggle = !passToggle;
                            });
                          },
                          child: Icon(passToggle
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF91AD13)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            )),
                        enabledBorder: const OutlineInputBorder(
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
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.validate();
                      },
                      child: Text('SignUp'),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 3),
                  child: Container(
                    child: Row(children: [
                      const Text('Already have an account?'),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    color: Color(
                                      0xFF91AD13,
                                    ),
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      )
                    ]),
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
