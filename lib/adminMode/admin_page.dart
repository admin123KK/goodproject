import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodproject/adminMode/admin_notfiy_.dart';
import 'package:goodproject/adminMode/create_newItems.dart';
import 'package:goodproject/adminMode/order_details.dart';
import 'package:goodproject/test/testdata.dart';
import 'package:goodproject/verifypages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int notificationCount = 0;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance //notification Counter to update from setstate
        .collection('adminData')
        // .where('seen', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        notificationCount = snapshot.docs.length;
      });
    });
  }

  // void _markNotificationSeen() async {
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('cashOrder')
  //       .where('seen', isEqualTo: true)
  //       .get();
  //   for (QueryDocumentSnapshot doc in snapshot.docs) {
  //     await doc.reference.update({'seen': true});
  //   }
  //   setState(() {
  //     notificationCount = 0;
  //   });
  // }

  Future<void> _showLogOUtDialog(BuildContext, context) {
    //for the showdialog of the logout
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Logout',
              style: const TextStyle(fontFamily: 'Mooli'),
            ),
            content: const Text(
              'Are you sure want logout ?',
              style: TextStyle(color: Colors.red, fontFamily: 'Mooli'),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF91AD13),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    // await _auth.signOut();
                    GoogleSignIn googleSignIn =
                        GoogleSignIn(); //for the signout
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF91AD13),
        title: const Text(
          'Khaja Ghar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Mooli',
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showLogOUtDialog(BuildContext, context);
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Admin Pannel',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: () async {
                  // _markNotificationSeen();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminNotify()));
                },
                child: Container(
                  alignment: Alignment.topRight,
                  child: notificationCount > 0
                      ? Badge(
                          label: Text(notificationCount.toString()),
                          child: const Icon(
                            Icons.notifications_active,
                            color: Colors.black,
                            size: 27,
                          ),
                        )
                      : const Icon(
                          Icons.notifications_active,
                          size: 27,
                          color: Colors.black,
                        ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderDetails()));
              },
              child: Container(
                alignment: Alignment.topLeft,
                child: const Row(
                  children: [
                    Icon(
                      Icons.list_alt,
                      size: 35,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Order Details'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateNew()));
              },
              child: Container(
                child: const Row(
                  children: [
                    Icon(
                      Icons.fastfood_rounded,
                      color: Colors.pink,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(" Create New Item's")
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DataAnalysisPage()));
              },
              child: Container(
                child: const Row(
                  children: [
                    Icon(
                      Icons.delivery_dining,
                      color: Colors.orange,
                      size: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Manage Order Status')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
