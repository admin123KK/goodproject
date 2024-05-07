import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:goodproject/items/cart.dart';

class PhiniPage extends StatefulWidget {
  const PhiniPage({super.key});

  @override
  State<PhiniPage> createState() => _PhiniPageState();
}

class _PhiniPageState extends State<PhiniPage> {
  int _quantity = 1;
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
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              'Phini',
                              style: TextStyle(
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
                                      const Text(
                                        '4 Star Rating',
                                        style: TextStyle(color: Colors.orange),
                                      )
                                    ],
                                  ),
                                  const Column(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        child: Text(
                                          'Rs.95',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 2, 99, 6),
                                              fontSize: 27),
                                        ),
                                      ),
                                      Text("/per piece"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 27),
                            child: Row(
                              children: [
                                Text(
                                  ('Description'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 27),
                            child: Text(
                              "Phini Roti is also a popular traditional sweet dish in Nepali cuisine. In Nepal, it is known as 'Phini' or 'Phini Roti'and is made similarly to the Indian version. It consists of a thin, lacy pancake made from a batter of wheat flour, ghee (clarified butter), and sugar, cooked on a flat griddle until crispy and golden. Phini Roti is often enjoyed as a dessert or snack, especially during festive occasions and celebrations in Nepali culture.",
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
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 27),
                            child: Text(
                              'Customize you Order',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 27),
                            child: Text('No of piece you want'),
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
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 27,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
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
                                                'Total amounts: Rs.${_calculateAmountTotal()}',
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 28, 139, 31),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text('Pay with'),
                                              Divider(
                                                thickness: 0.5,
                                                color: Colors.grey[600],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
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
                                              Text('OR'),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Confirm on Cash on delivery',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 28, 139, 31)),
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
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 34,
                                  width: 95,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF91AD13),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: const Text(
                                    'Order Now',
                                    style: TextStyle(
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
