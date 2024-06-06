import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goodproject/adminMode/admin_page.dart';
import 'package:goodproject/firebase_options.dart';
import 'package:goodproject/verifypages/signup_page.dart';

class AdminMode extends StatefulWidget {
  const AdminMode({super.key});

  @override
  State<AdminMode> createState() => _AdminModeState();
}

class _AdminModeState extends State<AdminMode> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool passToggle = true;
  String email = "";
  String password = "";

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              // TODO: Handle this case.
              case ConnectionState.waiting:
              // TODO: Handle this case.
              case ConnectionState.active:
              // TODO: Handle this case.
              case ConnectionState.done:
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: SafeArea(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                'Admin Login',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 0),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Enter your admin details for login',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            Container(
                              height: 269,
                              width: 269,
                              child: Image.asset('assets/images/signup.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: TextFormField(
                                  controller: _email,
                                  cursorColor: const Color(0xFF91AD13),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    focusColor: Color(0xFF91AD13),
                                    hintText: 'enter a username',
                                    labelText: 'username',
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    prefixIcon:
                                        const Icon(Icons.email_outlined),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF91AD13),
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF91AD13),
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    //validatorEmail
                                    if (value!.isEmpty) {
                                      return 'Please enter a username';
                                    } else {
                                      RegExp emailRegExp = RegExp(
                                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                      if (!emailRegExp.hasMatch(value)) {
                                        return 'Invalid username';
                                      } else {
                                        return null;
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: TextFormField(
                                  cursorColor: const Color(0xFF91AD13),
                                  controller: _password,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: passToggle,
                                  decoration: InputDecoration(
                                    hintText: 'enter a password',
                                    labelText: 'password',
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    suffix: InkWell(
                                      onTap: () {
                                        //passSeenUnseen
                                        setState(() {
                                          passToggle = !passToggle;
                                        });
                                      },
                                      child: Icon(passToggle
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF91AD13))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF91AD13))),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'enter a password';
                                    } else if (value.length < 6) {
                                      return 'invalid password';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 27,
                            ),
                            Container(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF91AD13),
                                  ),
                                ),
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Color(0xFF91AD13),
                                          ),
                                        );
                                      });
                                  final email = _email.text;
                                  final password = _password.text;
                                  try {
                                    final userCredential = await FirebaseAuth
                                        .instance
                                        .signInWithEmailAndPassword(
                                            email: email, password: password);
                                    print(userCredential);
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminPage()),
                                        (route) => false);
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'invalid-email') {
                                      await showErrorDialog(
                                          context, 'Invlaid email address');
                                      print(e.code);
                                    } else if (e.code == 'wrong-password') {
                                      return showErrorDialgo(
                                          context, 'Wrong passwrod');
                                    } else if (e.code == 'invalid-credential') {
                                      await showErrorDialog(
                                          context, 'Invalid credential');
                                    } else if (e.code == 'channel-error') {
                                      await showErrorDialog(context,
                                          'check email or password once');
                                      print(e.code);
                                    }
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
            }
          }),
    );
  }
}

Future<void> showErrorDialog(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(
            Icons.cancel,
            color: Colors.red,
          ),
          alignment: Alignment.center,
          title: const Text(
            'Error Occured',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            text,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF91AD13)),
                ))
          ],
        );
      });
}
