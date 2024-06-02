import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodproject/app_localization.dart';
import 'package:goodproject/items/Batuk_page.dart';
import 'package:goodproject/items/Chukauni_page.dart';
import 'package:goodproject/items/Phini_page.dart';
import 'package:goodproject/items/Selroti.dart';
import 'package:goodproject/items/notification_page.dart';
import 'package:goodproject/my_orderpage.dart';
import 'package:goodproject/setting_page.dart';
import 'package:goodproject/verifypages/location_page.dart';
import 'package:goodproject/verifypages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _LoginPageState();
}

class _LoginPageState extends State<HomePage> {
  String userEmail = "";
  String userName = "";
  String userPhoto = "";
  String greeting = "";
  int notificationCount = 0;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          userEmail = user.email ?? "";
          userName = user.displayName ?? "";
          userPhoto = user.photoURL ?? "";
          updateGreeting();
        });
      }
    });
    FirebaseFirestore.instance
        .collection('cashPay')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        notificationCount = snapshot.docs
            .length; // Update notification count based on the number of documents
      });
    });
  }

  void updateGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    if (hour < 12) {
      setState(() {
        greeting = AppLocalizations.of(context).translate('GoodMorning');
      });
    } else if (hour < 17) {
      setState(() {
        greeting = AppLocalizations.of(context).translate('GoodAfternoon');
      });
    } else {
      setState(() {
        greeting = AppLocalizations.of(context).translate('GoodEvening');
      });
    }
  }

  Widget foodItem({required String image, required String name}) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          height: 110,
          width: 90,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                offset: const Offset(0, 3),
                blurRadius: 10,
              )
            ],
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          name,
          style:
              const TextStyle(fontFamily: 'Mooli', fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget popularItem(
      {required String name,
      required String image,
      required String price,
      required}) {
    return InkWell(
      onTap: () {
        if (name == AppLocalizations.of(context).translate('SelRoti')) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SelRotiPage()));
        } else if (name == AppLocalizations.of(context).translate('Phini')) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PhiniPage()));
        } else if (name == AppLocalizations.of(context).translate('Batuk')) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BatukPage()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChukauniPage()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 175,
          height: 255,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(image),
                radius: 60,
              ),
              ListTile(
                leading: Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                trailing: Text(
                  price,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.green),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.orange),
                  Icon(Icons.star, color: Colors.orange),
                  Icon(Icons.star, color: Colors.orange),
                  Icon(Icons.star),
                  Icon(Icons.star),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showLogOUtDialog(BuildContext, context) {
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: const Text(
              'Logout',
              style: const TextStyle(fontFamily: 'Mooli'),
            ),
            content: Text(
              AppLocalizations.of(context).translate('areYou'),
              style: const TextStyle(color: Colors.red, fontFamily: 'Mooli'),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context).translate('cancel'),
                  style: const TextStyle(
                    color: Color(0xFF91AD13),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    // await _auth.signOut();
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    googleSignIn.disconnect();
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                        (route) => false);
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          //   GestureDetector(
          //     onTap: () {
          //       showDialog(
          //           context: context,
          //           builder: (BuildContext context) {
          //             return const Center(
          //               child: CircularProgressIndicator(
          //                 color: Color(0xFF91AD13),
          //               ),
          //             );
          //           });
          //       Timer(Duration(seconds: 1), () {
          //         Navigator.pop(context);
          //         // Navigator.push(
          //         //   context,
          //         //   MaterialPageRoute(builder: (context) => CartPage()),
          //         // );
          //       });
          //     },
          //     child: const Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 18),
          //       child: Icon(
          //         Icons.notifications_active_outlined,
          //         color: Colors.black,
          //         size: 29,
          //       ),
          //     ),
          //   ),
          Padding(
            padding: EdgeInsets.all(14),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Color(0xFF91AD13),
                      ));
                    });
                Timer(Duration(seconds: 1), () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage()));
                });
              },
              child: Badge(
                label: Text(notificationCount.toString()),

                // largeSize: 40,
                child: const Icon(
                  Icons.notifications_active_outlined,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
        title: Text(
          AppLocalizations.of(context).translate('khajaGhar'),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Mooli',
          ),
        ),
        backgroundColor: const Color(0xFF91AD13),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting, $userName',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Mooli',
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            offset: Offset(0, 3),
                            blurRadius: 10),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            width: 300,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                cursorColor: Colors.grey,
                                // focusNode: _foucusNode,
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .translate('wyouLike'),
                                    border: InputBorder.none),
                                onTap: () {
                                  showSearch(
                                      context: context,
                                      delegate: CustomSearch());
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    AppLocalizations.of(context).translate('categories'),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        foodItem(
                            image: 'assets/images/selroti.png',
                            name:
                                AppLocalizations.of(context).translate('all')),
                        foodItem(
                            image: 'assets/images/selroti.png',
                            name: AppLocalizations.of(context)
                                .translate('SelRoti')),
                        foodItem(
                            image: 'assets/images/phini.png',
                            name: AppLocalizations.of(context)
                                .translate('Phini')),
                        foodItem(
                            image: 'assets/images/batuk.png',
                            name: AppLocalizations.of(context)
                                .translate('Batuk')),
                        foodItem(
                            image: 'assets/images/chukauni.png',
                            name: AppLocalizations.of(context)
                                .translate('Chukauni')),
                        foodItem(
                            image: 'assets/images/momo.png',
                            name:
                                AppLocalizations.of(context).translate('Momo')),
                        foodItem(
                            image: 'assets/images/Chow-mein.png',
                            name: AppLocalizations.of(context)
                                .translate('Chowmein')),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    AppLocalizations.of(context).translate('Popular'),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: 450,
                    child: GridView.count(
                      shrinkWrap: false,
                      primary: false,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: [
                        popularItem(
                            name: AppLocalizations.of(context)
                                .translate('SelRoti'),
                            image: 'assets/images/selroti.png',
                            price: 'Rs.200'),
                        popularItem(
                            name:
                                AppLocalizations.of(context).translate('Phini'),
                            image: 'assets/images/phini.png',
                            price: 'Rs.300'),
                        popularItem(
                            name:
                                AppLocalizations.of(context).translate('Batuk'),
                            image: 'assets/images/batuk.png',
                            price: 'Rs.60'),
                        popularItem(
                            name: AppLocalizations.of(context)
                                .translate('Chukauni'),
                            image: 'assets/images/chukauni.png',
                            price: 'Rs.50'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userName),
              accountEmail: Text(userEmail),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image(
                    image: NetworkImage(userPhoto),
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1613425293967-16ae72140466?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8M'),
                      fit: BoxFit.fill)),
            ),
            const ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: Text('Home'),
            ),
            ListTile(
              leading: const Icon(
                Icons.place_outlined,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LocationPage()));
              },
              title: const Text('Location'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingPage()));
              },
              leading: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: const Text('Settings'),
            ),
            ListTile(
              leading: const Icon(
                Icons.delivery_dining_rounded,
                color: Colors.black,
              ),
              title: const Text(
                'My order',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderPage()));
              },
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.feedback,
                color: Colors.black,
              ),
              title: const Text('Feedback'),
            ),
            const ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.black,
              ),
              title: Text('Help'),
            ),
            const ListTile(
              leading: Icon(
                Icons.share,
                color: Colors.black,
              ),
              title: Text(
                'Share',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                'Logout',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                _showLogOUtDialog(BuildContext, context);
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomSearch extends SearchDelegate {
  List<String> allData = ['SelRoti', 'Phini', 'Batuk', 'Chukauni'];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
            onTap: () {
              if (result == 'SelRoti') {
                Navigator.pushNamed(context, 'SelRoti/');
              } else if (result == 'Phini') {
                Navigator.pushNamed(context, 'PhiniPage/');
              } else if (result == 'Batuk') {
                Navigator.pushNamed(context, 'BatukPage/');
              } else if (result == 'Chukauni') {
                Navigator.pushNamed(context, 'ChukauniPage/');
              }
            },
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}
