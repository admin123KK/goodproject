import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userName = "";

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName ?? "";
      });
    }
  }

  Future<void> _editUser(String userId) async {
    String newName = "";
    String newEmail = "";
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit USer'),
            content: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    newName = value;
                  },
                  decoration: InputDecoration(labelText: 'New Name'),
                ),
                TextField(
                  onChanged: (value) {
                    newEmail = value;
                  },
                  decoration: InputDecoration(labelText: 'New Email'),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    await firestore
                        .collection("Employee")
                        .doc(userId)
                        .update({'Name': newName, "Email": newEmail});
                    Navigator.pop(context);
                  },
                  child: Text('Save'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 70),
            child: StreamBuilder(
              stream: firestore.collection("Employee").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot user = snapshot.data!.docs[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                            user['Name'] ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(user['Email'] ?? ''),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  _editUser(user.id);
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    // Perform deletion from Firestore
                                    firestore
                                        .collection("Employee")
                                        .doc(user.id)
                                        .delete();
                                  });
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Container(
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(
              color: const Color(0xFF91AD13),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                    iconSize: 30,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'My Cart',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Mooli',
                    fontSize: 27,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 100,
                width: 600,
                decoration: const BoxDecoration(
                  color: Color(0xFF91AD13),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(27),
                    topRight: Radius.circular(27),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 35,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Total amounts',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  // Add your order logic here
                                },
                                child: Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Order Now',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'Rs.500',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: "Mooli",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
