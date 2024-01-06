import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifictionPage extends StatefulWidget {
  const VerifictionPage({super.key});

  @override
  State<VerifictionPage> createState() => _VerifictionPageState();
}

class _VerifictionPageState extends State<VerifictionPage> {
  final _formKey = GlobalKey<FormState>();
  int _counter = 60;
  late Timer _timer;
  bool _timerActive = true;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          _timerActive = false;
        }
      });
    });
  }

  void resetTimer() {
    setState(() {
      _counter = 30;
      _timerActive = true;
    });
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Verification Code',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "We have sent OTP to your email address",
                      style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 75,
                        width: 75,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: '*',
                              hintStyle: TextStyle(fontSize: 30),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF91AD13),
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    25,
                                  ),
                                  borderSide: BorderSide(color: Colors.black))),
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey[500],
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                    Container(
                      height: 75,
                      width: 75,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: '*',
                            hintStyle: TextStyle(fontSize: 30),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF91AD13),
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  25,
                                ),
                                borderSide: BorderSide(color: Colors.black))),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey[500]),
                    ),
                    Container(
                      height: 75,
                      width: 75,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: '*',
                            hintStyle: TextStyle(fontSize: 30),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF91AD13)),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  25,
                                ),
                                borderSide: BorderSide(color: Colors.black))),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey[500]),
                    ),
                    Container(
                      height: 75,
                      width: 75,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: '*',
                            hintStyle: TextStyle(fontSize: 30),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF91AD13),
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  25,
                                ),
                                borderSide: BorderSide(color: Colors.black))),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).enclosingScope;
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey[500]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 300,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF91AD13))),
                    onPressed: () {},
                    child: Text(
                      'Verify ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Didn't  receive any code?",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    _counter > 0
                        ? Text(
                            ' $_counter seconds',
                            style: TextStyle(fontSize: 13),
                          )
                        : GestureDetector(
                            onTap: () {
                              resetTimer();
                            },
                            child: Text(
                              'Resend code',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF91AD13),
                              ),
                            ),
                          )
                    // Container(
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     child: Text(
                    //       'Resend New ',
                    //       style: TextStyle(color: Color(0xFF91AD13)),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
