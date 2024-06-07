import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:goodproject/app_localization.dart';
import 'package:goodproject/functions/esea_page.dart';
import 'package:goodproject/items/cart.dart';

class PhiniPage extends StatefulWidget {
  const PhiniPage({super.key});

  @override
  State<PhiniPage> createState() => _PhiniPageState();
}

class _PhiniPageState extends State<PhiniPage> {
  int _quantity = 0;
  double Item_price = 95;

  double _calculateAmountTotal() {
    double totalAmount = Item_price * _quantity;
    if (_quantity >= 10) {
      totalAmount -= 40;
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
        'itemName': 'Phini',
        'quantity': _quantity,
        'totalCost': _calculateAmountTotal(),
      });
      print('added to the card successfuly');
    } catch (e) {
      print('Error adding item  $e');
    }
  }

  Future<void> processOrder() async {
    try {
      await FirebaseFirestore.instance.collection('cashPay').add({
        'itemName': 'Phini',
        'quantity': _quantity,
        'totalCost': _calculateAmountTotal(),
        'dateTime': DateTime.now(),
        'Email': FirebaseAuth.instance.currentUser?.email,
        'Name': FirebaseAuth.instance.currentUser?.displayName,
        'seen': false
      });
      print('Order cash Sucess');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Congratualations !! Your order is placed",
            style: TextStyle(color: Color(0xFF91AD13)),
          ),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      );
    } catch (e) {
      print('Error in order $e');
    }
  }

//trigger notification
  triggerNotification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 2,
      channelKey: 'Khaja_App',
      title: 'Khaja Ghar',
      body: 'Your Order Phini is placed to the Khaja Ghar',
      color: const Color(0xFF91AD13),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/phini.png',
              fit: BoxFit.cover,
            ),
            Container(
              height: 350,
              width: 460,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 26, 20, 20),
                    Colors.transparent,
                    Color.fromARGB(255, 22, 17, 13)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 33, horizontal: 12),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      InkWell(
                        child: IconButton(
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
                                      builder: (context) => CartPage()));
                            });
                          },
                          icon:
                              const Icon(Icons.shopping_cart_checkout_outlined),
                          color: Colors.white,
                          iconSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
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
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              AppLocalizations.of(context).translate('Phini'),
                              style: const TextStyle(
                                  fontFamily: 'Mooli',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        style: const TextStyle(
                                            color: Colors.orange),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('Rs_95'),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 2, 99, 6),
                                              fontSize: 27),
                                        ),
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
                            height: 14,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 27),
                            child: Row(
                              children: [
                                Text(
                                  (AppLocalizations.of(context)
                                      .translate('Descriptions')),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 27),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('explain2'),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 27),
                            child: Divider(
                              thickness: 1.5,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 27),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('customize'),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 27),
                            child: Text(AppLocalizations.of(context)
                                .translate('noPiece')),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 27),
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
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: const Text(
                                      '-',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 9,
                                ),
                                Container(
                                  height: 33,
                                  width: 46,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xFF91AD13),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF91AD13),
                                          ),
                                        ),
                                        hintText: _quantity.toString(),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 7)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: incrementQuantity,
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 33,
                                        width: 44,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF91AD13),
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: const Text(
                                          '+',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 75,
                                ),
                                Container(
                                  height: 35,
                                  width: 130,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                        focusColor: const Color(0xFF91AD13),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xFF91AD13)),
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xFF91AD13)),
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        labelText: AppLocalizations.of(context)
                                            .translate('shareLocation'),
                                        labelStyle: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 15)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 33),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('total_costs')
                                      .replaceAll('{cost}',
                                          _calculateAmountTotal().toString()),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: InkWell(
                                  onTap: () {
                                    addToCart();
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 99,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF91AD13),
                                        borderRadius: BorderRadius.circular(9)),
                                    child: Center(
                                        child: Text(
                                      AppLocalizations.of(context)
                                          .translate('cart'),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
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
                                                  fontSize: 27,
                                                  fontFamily: 'Mooli',
                                                  fontWeight: FontWeight.bold),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
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
                                                      onTap: () {
                                                        Esewa esewa = Esewa();
                                                        esewa.pay();
                                                      },
                                                      child: ClipOval(
                                                        child: Image.asset(
                                                          'assets/images/esewa.png',
                                                          height: 45,
                                                          width: 45,
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
                                                Text(
                                                    AppLocalizations.of(context)
                                                        .translate('or')),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  processOrder();
                                                  Timer(
                                                      const Duration(
                                                          seconds: 3), () {
                                                    return triggerNotification(); //tigger notification fetch
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
                                              )
                                            ],
                                          );
                                        });
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 34,
                                  width: 125,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF91AD13),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('OrderNow'),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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
