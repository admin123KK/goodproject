import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goodproject/verifypages/firebase_options.dart';
import 'package:goodproject/verifypages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  late final Function()? onTap;
  late final TextEditingController _email;
  late final TextEditingController _password;

  bool passToggle = true;

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
            options: DefaultFirebaseOptions.currentPlatform,
          ),
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
                                  'Create Account ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 0),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Enter your details to signup',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[600]),
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
                                  // height: 55,
                                  // width: 400,
                                  child: TextFormField(
                                    controller: _nameController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    cursorColor: Color(0xFF91AD13),
                                    decoration: const InputDecoration(
                                      hintText: " Enter your name",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      labelText: 'Full Name',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
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
                                      } else if (value.length < 4) {
                                        return "character should be more than 5";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // height: 55,
                                  // width: 400,
                                  child: TextFormField(
                                    controller: _email,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    cursorColor: Color(0xFF91AD13),
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                      prefixIcon: Icon(Icons.email_outlined),
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      hintText: 'Enter your email',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF91AD13)),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF91AD13)),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "please enter mail";
                                      } else {
                                        RegExp emailRegExp = RegExp(
                                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                        if (!emailRegExp.hasMatch(value)) {
                                          return "please enter the valid mail  ";
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
                                  // height: 55,
                                  // width: 400,
                                  child: TextFormField(
                                    obscureText: passToggle,
                                    controller: _password,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    cursorColor: Color(0xFF91AD13),
                                    decoration: InputDecoration(
                                      labelText: 'New password',
                                      prefixIcon:
                                          const Icon(Icons.lock_outlined),
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
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
                                          borderSide: BorderSide(
                                              color: Color(0xFF91AD13)),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          )),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF91AD13)),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please enter password';
                                      } else if (value.length < 6) {
                                        return "at least  6 character requried";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // height: 55,
                                  // width: 400,
                                  child: TextFormField(
                                    cursorColor: Color(0xFF91AD13),
                                    obscureText: passToggle,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm  password',
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      hintText: 'Confirm your Password',
                                      prefixIcon:
                                          const Icon(Icons.lock_outline),
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
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF91AD13)),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          )),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF91AD13)),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "please enter your password";
                                      } else if (value.length < 6) {
                                        return "invalid password";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 400,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFF91AD13))),
                                    onPressed: () async {
                                      // _formKey.currentState!.validate();
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Color(0xFF91AD13),
                                              ),
                                            );
                                          });

                                      final email = _email.text;
                                      final password = _password.text;
                                      try {
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: email,
                                                password: password);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.black,
                                            content: const Text(
                                              'You are registered!!',
                                              style: TextStyle(
                                                  color: Color(0xFF91AD13)),
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),
                                        );
                                        Navigator.of(context)
                                            .pushNamed('VerifictionPage/');
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'email-already-in-use') {
                                          await showErrorDialgo(context,
                                              'Email already use try another');
                                          print('try another email address ');
                                        } else if (e.code == 'invalid-email') {
                                          await showErrorDialgo(
                                              context, 'Invalid email address');
                                        } else if (e.code == 'weak-password') {
                                          await showErrorDialgo(
                                              context, 'Weak Password');
                                        } else if (e.code == 'channel-error') {
                                          await showErrorDialgo(
                                              context, 'Invalid Credential');
                                        } else {
                                          print(e.code);
                                        }
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      'or continue with',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ),
                                  Expanded(
                                      child: Divider(
                                    thickness: 0.5,
                                    color: Colors.grey[600],
                                  ))
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        height: 75,
                                        width: 75,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Image.asset(
                                          'image/assets/facebook.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Color(0xFF91AD13),
                                              ),
                                            );
                                          },
                                        );
                                        signInWithGoogle();
                                        // Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 75,
                                        width: 75,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey[200],
                                        ),
                                        child: Image.asset(
                                            'image/assets/google.png'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 70, vertical: 2),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        'Already have an account?',
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginPage()));
                                            },
                                            child: const Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: Color(
                                                    0xFF91AD13,
                                                  ),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
            }
          }),
    );
  }
}

Future<void> showErrorDialgo(
  BuildContext context,
  String text,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(' Error occured'),
          icon: Icon(Icons.cancel),
          content: Text(
            textAlign: TextAlign.center,
            text,
            style: const TextStyle(color: Colors.red),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF91AD13),
                ),
              ),
            ),
          ],
        );
      });
}
