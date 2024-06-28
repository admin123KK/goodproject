import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:goodproject/app_localization.dart';
import 'package:goodproject/functions/esea_page.dart';
import 'package:goodproject/items/cart.dart';

class ChukauniPage extends StatefulWidget {
  const ChukauniPage({super.key});

  @override
  State<ChukauniPage> createState() => _ChukauniPageState();
}

class _ChukauniPageState extends State<ChukauniPage> {
  int _quantity = 0;
  double Item_price = 50;

  double _calculateAmountTotal() {
    double totalAmount = Item_price * _quantity;
    if (_quantity >= 10) {
      totalAmount -= 20;
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
        'itemName': 'Chukaune',
        'quantity': _quantity,
        'totalCost': _calculateAmountTotal(),
        'Email': FirebaseAuth.instance.currentUser?.email
      });
      print('add to cart sucessufuely');
    } catch (e) {
      print('Error adding item:$e');
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: const Center(
            child: Text(
          'Successfully added to cart !!',
          style: TextStyle(color: Color(0xFF91AD13)),
        ))));
  }

  Future<void> processOrder() async {
    try {
      await FirebaseFirestore.instance.collection('cashPay').add({
        'itemName': 'Chukauni',
        'quantity': _quantity,
        'totalCost': _calculateAmountTotal(),
        'dateTime': DateTime.now(),
        'Email': FirebaseAuth.instance.currentUser?.email,
        'Name': FirebaseAuth.instance.currentUser?.displayName,
        'seen': false
      });
      print('Order cash successful');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'Congratulations !! You order is placed',
          style: TextStyle(
            color: Color(0xFF91AD13),
          ),
        ),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ));
    } catch (e) {
      print('order error $e');
    }
  }

  //triggerNotification function
  triggerNotification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 4,
      channelKey: 'Khaja_App',
      title: 'Khaja Ghar',
      body: 'Your Order Chukauni is placed in the Khaja Ghar',
      backgroundColor: const Color(0xFF91AD13),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(children: [
      Image.asset(
        'assets/images/chukauni.png',
        fit: BoxFit.cover,
        height: 340,
        width: 500,
      ),
      Container(
        height: 340,
        width: 460,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 26, 22, 22),
            Colors.transparent,
            Color.fromARGB(255, 29, 26, 26)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Padding(
              padding: EdgeInsets.symmetric(vertical: 33, horizontal: 9),
              child: Icon(
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
                    color: Colors.white,
                    size: 30,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Column(
                children: [
                  const SizedBox(
                    height: 220,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 33),
                          child: Text(
                            AppLocalizations.of(context).translate('Chukauni'),
                            style: const TextStyle(
                                fontFamily: 'Mooli',
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
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
                                      itemSize: 17,
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
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('StarRatings'),
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('Rs_50'),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 2, 99, 6),
                                          fontSize: 27),
                                    ),
                                    Text(AppLocalizations.of(context)
                                        .translate('/perPiece')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('Descriptions'),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            AppLocalizations.of(context).translate('explain3'),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Divider(
                            thickness: 1.5,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            AppLocalizations.of(context).translate('customize'),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(AppLocalizations.of(context)
                                  .translate('noPiece')),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: decrementQuantity,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 33,
                                  width: 44,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF91AD13),
                                      borderRadius: BorderRadius.circular(27)),
                                  child: const Text(
                                    '-',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Container(
                                height: 33,
                                width: 44,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      focusColor: const Color(0xFF91AD13),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFF91AD13), width: 2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: Color(0xFF91AD13),
                                        ),
                                      ),
                                      hintText: _quantity.toString(),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 5)),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              InkWell(
                                onTap: incrementQuantity,
                                child: Container(
                                  height: 33,
                                  width: 44,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF91AD13),
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                  child: const Text(
                                    '+',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 60,
                              ),
                              Container(
                                height: 30,
                                width: 130,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      focusColor: const Color(0xFF91AD13),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF91AD13),
                                        ),
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF91AD13)),
                                      ),
                                      labelText: AppLocalizations.of(context)
                                          .translate('shareLocation'),
                                      labelStyle: const TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('total_costs')
                                    .replaceAll('{cost}',
                                        _calculateAmountTotal().toString()),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: InkWell(
                                onTap: () {
                                  addToCart();
                                },
                                child: Container(
                                  height: 30,
                                  width: 99,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF91AD13),
                                      borderRadius: BorderRadius.circular(9)),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('cart'),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        // const SizedBox(
                        //   height: 30,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 44),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Color(0xFF91AD13),
                                          ),
                                        );
                                      });
                                  Timer(Duration(seconds: 2), () {
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              'Payement Status',
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
                                                      .translate('total_amount')
                                                      .replaceAll(
                                                          '{amount}',
                                                          _calculateAmountTotal()
                                                              .toString()),
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 28, 139, 31),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                    AppLocalizations.of(context)
                                                        .translate('payWith')),
                                                Divider(
                                                  thickness: 0.5,
                                                  color: Colors.grey[600],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        Esewa esewa = Esewa(
                                                          context: context,
                                                        );
                                                        await esewa.pay();
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
                                                    ClipOval(
                                                      child: Image.asset(
                                                        'assets/images/khalti.png',
                                                        height: 65,
                                                        width: 65,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                    AppLocalizations.of(context)
                                                        .translate('or'))
                                              ],
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  processOrder();
                                                  Timer(Duration(seconds: 3),
                                                      () {
                                                    return triggerNotification();
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  AppLocalizations.of(context)
                                                      .translate('confirmCash'),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 28, 139, 31)),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  AppLocalizations.of(context)
                                                      .translate('cancel'),
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 40),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 33,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF91AD13),
                                      borderRadius: BorderRadius.circular(27),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('OrderNow'),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ])));
  }
}
