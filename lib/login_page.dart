import 'package:flutter/material.dart';
import 'package:http/retry.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Login Account',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
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
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'enter your username ',
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
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
                        controller: _passwordController,
                        obscureText: passToggle,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          labelText: 'Password',
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
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
                          onPressed: () {},
                          child: Text('Forgot Password?',
                              style: TextStyle(
                                  color: Color(0xFF91AD13), fontSize: 13)))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 400,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xFF91AD13),
                          ),
                        ),
                        onPressed: () {
                          _formKey.currentState!.validate();
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Or continue with '),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[600],
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          'image/assets/facebook.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          'image/assets/google.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                   
                    ],
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 2),
                    child: Container(child: Row(
                      children: [
                        Text('Dont have account?'),
                    TextButton(onPressed: () {}, child: Text('SignUp'))
                    
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
