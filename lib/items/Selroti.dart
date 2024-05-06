import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SelRotiPage extends StatefulWidget {
  const SelRotiPage({super.key});

  @override
  State<SelRotiPage> createState() => _SelRotiPageState();
}

class _SelRotiPageState extends State<SelRotiPage> {
  int _quantity = 1;
  double Item_Price = 60;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Image.asset(
            'assets/images/selroti.png',
            fit: BoxFit.cover,
            height: 340,
            width: 450,
          ),
          Container(
            height: 340,
            width: 450,
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
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 9),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 27,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart_checkout,
                      size: 27,
                      color: Colors.white,
                    ),
                  ),
                ],
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
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'SelRoti',
                          style: TextStyle(
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
                                const Text(
                                  '3 Star Ratings',
                                  style: TextStyle(color: Colors.orange),
                                ),
                              ],
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Rs.60',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 2, 99, 6)),
                                ),
                                Text("/per piece")
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 33,
                        ),
                        child: Text(
                          "Description",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 33),
                        child: Text(
                          "Selroti is a traditional Nepali snack that holds a special place in the hearts and taste buds of many.This golden-brown, ring-shaped delicacy is made from rice flour batter mixed with sugar, milk, and sometimes spices like cardamom. The batter is deep-fried until it forms a crispy exterior while remaining soft and fluffy inside. Selroti is often enjoyed during festivals, celebrations, or as a tea-time treat.",
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
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Customize your Order',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text('No of piece you want'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Payement Total ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Mooli'),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Total amount : Rs.${_calculateTotalAmount()}',
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 22),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Pay with'),
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.5,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        'assets/images/esewa.png',
                                        width: 45,
                                        height: 45,
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
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('OR'),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Confirm Cash on Delivery',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.black),
                                  ))
                            ],
                          );
                        });
                  },
                  child: Container(
                    height: 36,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFF91AD13),
                      borderRadius: BorderRadius.circular(27),
                    ),
                    child: const Center(
                      child: Text(
                        'Order Now',
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
