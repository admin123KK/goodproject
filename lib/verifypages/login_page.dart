import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goodproject/verifypages/firebase_options.dart';
import 'package:goodproject/home_page.dart';
import 'package:goodproject/verifypages/signup_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late final Function()? onTap;
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool passToggle = true;
  String email = '';
  String password = '';

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.of(context)
        .pushNamedAndRemoveUntil('homepage/', (route) => false);
  }

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
    super.dispose();
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
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                'Login Account',
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
                                  'Enter your details to login',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            Container(
                              height: 269,
                              width: 269,
                              child: Image.asset('image/assets/signup.png'),
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
                                    focusColor: const Color(0xFF91AD13),
                                    hintText: 'enter your username ',
                                    labelText: 'Username',
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    prefixIcon:
                                        const Icon(Icons.email_outlined),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xFF91AD13)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF91AD13),
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter username";
                                    } else {
                                      RegExp emailRegExp = RegExp(
                                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                      if (!emailRegExp.hasMatch(value)) {
                                        return 'Invalid username ';
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
                                    hintText: 'Enter your password',
                                    labelText: 'Password',
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
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
                                      return 'please enter password';
                                    } else if (value.length < 6) {
                                      return 'wrong password';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, 'ForgotPassword/');
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                        color: Color(0xFF91AD13), fontSize: 13),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 400,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF91AD13),
                                    ),
                                  ),
                                  onPressed: () async {
                                    // _formKey.currentState!.validate();
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

                                    // Navigator.of(context)
                                    //     .pushNamed('homepage/');
                                    try {
                                      final userCredential = await FirebaseAuth
                                          .instance
                                          .signInWithEmailAndPassword(
                                              email: email, password: password);
                                      print(userCredential);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => HomePage(),
                                          ),
                                          (route) => false);
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'invalid-email') {
                                        await showErrorDialgo(
                                            context, 'Invalid email address');
                                        // print(
                                        //     'The email address you enter is incorrect');
                                        print(e.code);
                                      } else if (e.code == 'missing-password') {
                                        await showErrorDialgo(
                                            context, 'Missing password');
                                        // print(e.code);
                                        // print('Password is missing sir');
                                      } else if (e.code ==
                                          'invalid-credential') {
                                        // print(e.code);
                                        // print('password is incorrect');
                                        await showErrorDialgo(context,
                                            'username or password is incorrect');
                                      } else if (e.code == 'channel-error') {
                                        await showErrorDialgo(
                                            context, 'invalid credential');
                                      } else {
                                        print(e.code);
                                      }
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Or continue with ',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {},
                                  child: Container(
                                    height: 75,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset(
                                      'image/assets/facebook.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (contex) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: Color(0xFF91AD13),
                                            ),
                                          );
                                        });
                                    signInWithGoogle();
                                  },
                                  child: Container(
                                    height: 75,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset(
                                      'image/assets/google.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 2),
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Dont have account?',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignUp(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'SignUp',
                                        style:
                                            TextStyle(color: Color(0xFF91AD13)),
                                      ),
                                    )
                                  ],
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
          }),
    );
  }
}

Future<void> showErrorDialog(BuildContext, context, String text) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(
            Icons.cancel,
            color: Colors.red,
          ),
          alignment: Alignment.center,
          title: const Text(
            'Error occured',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            text,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Ok',
                style: TextStyle(
                  color: Color(0xFF91AD13),
                ),
              ),
            ),
          ],
        );
      });
}
