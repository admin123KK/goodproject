import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goodproject/firebase_options.dart';
import 'package:goodproject/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  late final TextEditingController _email;
  late final TextEditingController _password;

  bool passToggle = true;

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
                                  fontWeight: FontWeight.bold, fontSize: 30),
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
                                  } else if (value!.length < 4) {
                                    return "character should be more than 5";
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
                                controller: _email,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorColor: Color(0xFF91AD13),
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email_outlined),
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: 'Enter your email',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF91AD13)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF91AD13)),
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
                                  prefixIcon: const Icon(Icons.lock_outlined),
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
                                      borderSide:
                                          BorderSide(color: Color(0xFF91AD13)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      )),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF91AD13)),
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
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF91AD13)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      )),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF91AD13)),
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
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => VerifictionPage(),
                                  //     ));
                                  // _formKey.currentState!.validate();
                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(SnackBar(
                                  //   content: Text('Completed '),
                                  // ));
                                  final email = _email.text;
                                  final password = _password.text;
                                 final userCredential = FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password);
                                  if(userCredential !=null){
                                  print('successfuly register');
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.asset(
                                    'image/assets/facebook.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[200],
                                  ),
                                  child: Image.asset('image/assets/google.png'),
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
                                    style: TextStyle(color: Colors.grey[600]),
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
          }),
    );
  }
}
