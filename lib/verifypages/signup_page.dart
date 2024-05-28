import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goodproject/app_localization.dart';
import 'package:goodproject/database.dart';
import 'package:goodproject/verifypages/firebase_options.dart';
import 'package:goodproject/verifypages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:random_string/random_string.dart';

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
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .translate('creates'),
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
                                    AppLocalizations.of(context)!
                                        .translate('details'),
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[600]),
                                  ),
                                ),
                              ),
                              Container(
                                height: 260,
                                width: 400,
                                child: Image.asset('assets/images/signup.png'),
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
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .translate('enterfullName'),
                                      hintStyle: TextStyle(color: Colors.grey),
                                      labelText: AppLocalizations.of(context)
                                          .translate('fullName'),
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      prefixIcon:
                                          const Icon(Icons.person_2_outlined),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF91AD13),
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
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
                                        return AppLocalizations.of(context)
                                            .translate('enterName');
                                      } else if (value.length < 4) {
                                        return AppLocalizations.of(context)
                                            .translate('enterValidName');
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
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)
                                          .translate('email'),
                                      prefixIcon:
                                          const Icon(Icons.email_outlined),
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      hintText: AppLocalizations.of(context)
                                          .translate('enterYourMail'),
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
                                        return AppLocalizations.of(context)
                                            .translate('enterMail');
                                      } else {
                                        RegExp emailRegExp = RegExp(
                                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                        if (!emailRegExp.hasMatch(value)) {
                                          return AppLocalizations.of(context)
                                              .translate('enterValidMail');
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
                                      labelText: AppLocalizations.of(context)
                                          .translate('newPassword'),
                                      prefixIcon:
                                          const Icon(Icons.lock_outlined),
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      hintText: AppLocalizations.of(context)
                                          .translate('enterYourNewPass'),
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
                                        return AppLocalizations.of(context)
                                            .translate('pleaseEnterPassword');
                                      } else if (value.length < 6) {
                                        return AppLocalizations.of(context)
                                            .translate('pleaseEnter6Character');
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
                                      labelText: AppLocalizations.of(context)
                                          .translate('confirmPassword'),
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      hintText: AppLocalizations.of(context)
                                          .translate('confirmPassword'),
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
                                      String Id = randomAlphaNumeric(10);
                                      Map<String, dynamic> employeeInfoMap = {
                                        "Name": _nameController.text,
                                        "Email": _email.text,
                                      };
                                      await DatabaseMethods()
                                          .addEmployeeDetails(
                                              employeeInfoMap, Id);
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
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: email,
                                                password: password);
                                        final user =
                                            FirebaseAuth.instance.currentUser;
                                        await user?.sendEmailVerification();
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
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('signup'),
                                      style: const TextStyle(
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
                                      AppLocalizations.of(context)
                                          .translate('orContinueWith'),
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      thickness: 0.5,
                                      color: Colors.grey[600],
                                    ),
                                  )
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
                                          'assets/images/facebook.png',
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
                                            return const Center(
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
                                            'assets/images/google.png'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 2),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('alreadyHaveAccount'),
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
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('login'),
                                              style: const TextStyle(
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
