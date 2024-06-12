import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:goodproject/app_localization.dart';
import 'package:goodproject/functions/esea_page.dart';
import 'package:goodproject/items/cart.dart';

class ItemDetailPage extends StatefulWidget {
  final String name;
  final String image;
  final double price;
  final String description;

  const ItemDetailPage({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  int _quantity = 0;
  double Item_Price = 60;
  String userName = "";

  double _calculateTotalAmount() {
    double totalAmount = _quantity * Item_Price;
    if (_quantity >= 10) {
      totalAmount -= 30;
    }
    return totalAmount;
  }

  void incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  Future<void> addToCart() async {
    try {
      FirebaseFirestore.instance.collection('cart').add({
        'itemName': widget.name,
        'quantity': _quantity,
        'totalCost': _calculateTotalAmount(),
        'Email': FirebaseAuth.instance.currentUser?.email
      });
      print('added to cart sucessfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
          backgroundColor: Colors.black,
          content: const Center(
            child: Text(
              'Successfully  added to cart !!',
              style: TextStyle(color: Color(0xFF91AD13)),
            ),
          ),
        ),
      );
    } catch (e) {
      print('Error add item $e');
    }
  }

  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("UserInfo")
            .doc(user.uid)
            .get();

        setState(() {
          userName = userDoc['Name'];
        });
      }
    } catch (e) {
      print('Error fetching user name: $e');
    }
  }

  Future<void> cashOrder() async {
    try {
      FirebaseFirestore.instance.collection('cashPay').add({
        'itemName': widget.name,
        'quantity': _quantity,
        'totalCost': _calculateTotalAmount(),
        'dateTime': DateTime.now(),
        'Email': FirebaseAuth.instance.currentUser?.email,
        'Name': FirebaseAuth.instance.currentUser?.displayName,
        'seen': false
      });
      print('order sucess in cash');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Congratulations !! Your order is placed',
            style: TextStyle(
              color: Color(0xFF91AD13),
            ),
          ),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      );
    } catch (e) {
      print('order is $e');
    }
  }

//triggerNotification function used
  triggerNotifications() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'Khaja_App',
        title: 'Khaja Ghar',
        body: 'Your Order SelRoti is placed in the  Khaja Ghar',
        backgroundColor: const Color(0xFF91AD13),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Image.asset(
            widget.image,
            fit: BoxFit.cover,
            height: 340,
            width: 450,
          ),
          Container(
            height: 340,
            width: 470,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 27, 19, 19),
                Colors.transparent,
                Color.fromARGB(255, 13, 11, 11)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 33, horizontal: 9),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF91AD13),
                                ),
                              );
                            });
                        Timer(Duration(seconds: 1), () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartPage()));
                        });
                      },
                      icon: const Icon(
                        Icons.shopping_cart_checkout,
                        size: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 23),
                  child: SizedBox(
                    height: 220,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Mooli',
                              fontSize: 35),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                RatingBar.builder(
                                  initialRating: 3.5,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 1.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('StarRatings'),
                                  style: const TextStyle(color: Colors.orange),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('Rs_60'),
                                  style: const TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 2, 99, 6)),
                                ),
                                Text(
                                    'Price: \$${widget.price.toStringAsFixed(2)}')
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 33,
                        ),
                        child: Text(
                          widget.description,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 33),
                        child: Text(
                          AppLocalizations.of(context).translate('explain'),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        AppLocalizations.of(context).translate('customize'),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                          AppLocalizations.of(context).translate('noPiece')),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: decrementQuantity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            alignment: Alignment.center,
                            height: 33,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xFF91AD13)),
                            child: const Text(
                              '-',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 33,
                        width: 44,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF91AD13), width: 2.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF91AD13))),
                              hintText: _quantity.toString(),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 5)),
                        ),
                      ),
                      InkWell(
                        onTap: incrementQuantity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            alignment: Alignment.center,
                            height: 33,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xFF91AD13)),
                            child: const Text(
                              '+',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 53,
                      ),
                      Container(
                        height: 35,
                        width: 130,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              focusColor: const Color(0xFF91AD13),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFF91AD13)),
                                borderRadius: BorderRadius.circular(9),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF91AD13),
                                  ),
                                  borderRadius: BorderRadius.circular(7)),
                              labelText: AppLocalizations.of(context)
                                  .translate('shareLocation'),
                              labelStyle: TextStyle(
                                  color: Colors.grey[900], fontSize: 14)),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 33),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('total_costs')
                            .replaceAll(
                                '{cost}', _calculateTotalAmount().toString()),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 90,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: InkWell(
                        onTap: () {
                          addToCart();
                        },
                        child: Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFF91AD13),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Center(
                              child: Text(
                            AppLocalizations.of(context).translate('cart'),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 45,
                ),
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
                              'Payement Status ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27,
                                  fontFamily: 'Mooli'),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .translate(
                                        'total_amount',
                                      )
                                      .replaceAll('{amount}',
                                          _calculateTotalAmount().toString()),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 28, 139, 31),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(AppLocalizations.of(context)
                                    .translate('payWith')),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.5,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Esewa esewa = Esewa();
                                        esewa.pay();
                                      },
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
                                Text(AppLocalizations.of(context)
                                    .translate('or')),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  cashOrder();
                                  Navigator.pop(context);
                                  Timer(Duration(seconds: 3), () {
                                    return triggerNotifications();
                                  });
                                  // triggerNotifications();
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('confirmCash'),
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 28, 139, 31),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('cancel'),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    });
                  },
                  child: Container(
                    height: 36,
                    width: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF91AD13),
                      borderRadius: BorderRadius.circular(27),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).translate('OrderNow'),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}




  
// import 'package:flutter/material.dart';

// class ItemDetailPage extends StatefulWidget {
//   final String name;
//   final String image;
//   final double price;
//   final String description;

//   const ItemDetailPage({
//     Key? key,
//     required this.name,
//     required this.image,
//     required this.price,
//     required this.description,
//   }) : super(key: key);

//   @override
//   State<ItemDetailPage> createState() => _ItemDetailPageState();
// }

// class _ItemDetailPageState extends State<ItemDetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.name),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(
//               widget.image,
//               width: double.infinity,
//               height: 200,
//               fit: BoxFit.cover,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 widget.name,
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Price: \$${widget.price.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 widget.description,
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }