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
  double totalCosts = 0; // Changed to double
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
    // String newName = "";
    String editItems = "";
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Update Cart',
            style: TextStyle(fontFamily: "Mooli", fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  editItems = value;
                },
                decoration: InputDecoration(labelText: 'No of Items'),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () async {
                await firestore.collection('cart').doc(userId).update({
                  // 'itemName': newName,
                  'quantity': int.parse(editItems)
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Save',
                style: TextStyle(
                    color: Color(0xFF91AD13), fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      },
    );
  }
  //For updating the overall amounts in firestore testing
  // Future<void> updateTotalCost(double cost) async {
  //   await firestore
  //       .collection('totalCost')
  //       .doc('amount')
  //       .set({'totalAmount': cost});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: StreamBuilder(
              stream: firestore.collection("cart").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF91AD13),
                    ),
                  );
                } else {
                  totalCosts = 0; // Reset totalCosts
                  for (DocumentSnapshot item in snapshot.data!.docs) {
                    totalCosts += (item['totalCost'] ?? 0);
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot user = snapshot.data!.docs[index];
                            return Card(
                              child: ListTile(
                                title: Text(
                                  user['itemName'] ?? '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                        'No of item: ${user['quantity'].toString()}' ??
                                            ''),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                        'Total Costs: ${(user['totalCost'] ?? 0)}'
                                        ''),
                                  ],
                                ), // Convert quantity to String
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {
                                        _editUser(user.id);
                                      },
                                      icon: Icon(Icons.edit),
                                      color: Colors.black,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          // Perform deletion from Firestore
                                          firestore
                                              .collection('cart')
                                              .doc(user.id)
                                              .delete();
                                        });
                                      },
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xFF91AD13),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(27),
                            topRight: Radius.circular(27),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total amounts',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
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
                                      Future.delayed(Duration(seconds: 1), () {
                                        Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                'Payment Status',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 27,
                                                    fontFamily: 'Mooli'),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Total amount: Rs.${totalCosts.toStringAsFixed(2)}',
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 28, 139, 31),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text('Pay with'),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Divider(
                                                          thickness: 0.5,
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      GestureDetector(
                                                        child: ClipOval(
                                                          child: Image.asset(
                                                            'assets/images/esewa.png',
                                                            width: 45,
                                                            height: 45,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      GestureDetector(
                                                        child: ClipOval(
                                                          child: Image.asset(
                                                            'assets/images/khalti.png',
                                                            height: 65,
                                                            width: 65,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Text('OR'),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    'Confirm Cash on Delivery',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 28, 139, 31),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
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
                              Text(
                                ' Rs.${totalCosts.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                  fontFamily: "Mooli",
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
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
        ],
      ),
    );
  }
}
