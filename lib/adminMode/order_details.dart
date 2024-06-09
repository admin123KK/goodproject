import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key});

  @override
  State<OrderDetails> createState() => _CartPageState();
}

class _CartPageState extends State<OrderDetails> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  double totalCosts = 0;
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

  Future<void> updateQuantity(
      String userId, int currentQuantity, bool increment) async {
    DocumentSnapshot userDoc = //working on increseing and decreasing the items
        await firestore.collection('cart').doc(userId).get();
    double itemCost = userDoc['totalCost'] / userDoc['quantity'];
    int newQuantity = increment ? currentQuantity + 1 : currentQuantity - 1;
    double newTotalCost = newQuantity * itemCost;

    if (newQuantity > 0) {
      await firestore.collection('cart').doc(userId).update({
        'quantity': newQuantity,
        'totalCost': newTotalCost,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: StreamBuilder(
              stream: firestore.collection("cashPay").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
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
                            return Container(
                              height: 110,
                              width: 200,
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                    user['Name'] ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),

                                  subtitle: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Email :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Mooli',
                                                color: Colors.black),
                                          ),
                                          Text(
                                            ' ${user['Email']}',
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Item : ',
                                            style: TextStyle(
                                                fontFamily: 'Mooli',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            '${user['itemName']}',
                                            style: TextStyle(
                                                fontFamily: 'Mooli',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          const Text(
                                            'No of items : ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Mooli',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${user['quantity']}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 25),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const Text(
                                            'Total Cost :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontFamily: 'Mooli'),
                                          ),
                                          Text(
                                            '  Rs.${user['totalCost']}',
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Mooli'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ), // Convert quantity to String
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
                                'Total Revenue',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
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
                  GestureDetector(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      iconSize: 30,
                      color: Colors.black,
                    ),
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
                  'Order Details',
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
