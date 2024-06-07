import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goodproject/app_localization.dart';
import 'package:goodproject/verifypages/firebase_options.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                child: SafeArea(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('resetPassword'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('enterPassword'),
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 13.5),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            child: TextFormField(
                              controller: _emailController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)
                                      .translate('enterYourMail'),
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  labelText: AppLocalizations.of(context)
                                      .translate('email'),
                                  labelStyle: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF91AD13),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF91AD13),
                                    ),
                                  ),
                                  prefixIcon: const Icon(Icons.email_outlined)),
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
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 250,
                            child: ElevatedButton(
                              onPressed: () async {
                                final email = _emailController.text;
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: email);
                              },
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('resetPassword'),
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF91AD13),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('checkEmail'),
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'Loginpage/');
                            },
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('successBack'),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 188, 229, 6)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
