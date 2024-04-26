import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BatukPage extends StatefulWidget {
  const BatukPage({super.key});

  @override
  State<BatukPage> createState() => _BatukPageState();
}

class _BatukPageState extends State<BatukPage> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decermentQuantitiy() {
    if (quantity > 1) {
      setState(() {});
      quantity--;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          // alignment: Alignment.topCenter,
          children: [
            Image.asset(
              'assets/images/batuk.png',
              height: 340,
              width: 500,
              fit: BoxFit.cover,
            ),
            Container(
              height: 350,
              width: 420,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 26, 22, 22),
                  Colors.transparent,
                  Color.fromARGB(255, 21, 14, 14)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 7),
                  child: InkWell(
                    child: IconButton(
                      iconSize: 30,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      iconSize: 30,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_cart_checkout_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  ],
                )
              ],
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 57),
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
                              'Batuk',
                              style: TextStyle(
                                  fontFamily: 'Mooli',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 38),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  '3 star Rating',
                                  style: TextStyle(color: Colors.orange),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      'Rs.60',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color:
                                              Color.fromARGB(255, 9, 114, 12)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 22),
                                child: Text('8 /piece set '),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'Description',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              "It's a crispy, layered pastry made from refined wheat flour, sugar, ghee (clarified butter), and spices like cardamom and nutmeg.  After frying, it's dipped in sugar syrup flavored with cardamom and rose water to add sweetness and aroma. Batuk Khaja is often enjoyed during festivals, celebrations, and special occasions as a delightful treat symbolizing happiness and festivity in Nepali culture. ",
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 27, vertical: 10),
                      child: Divider(
                        thickness: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "Customize your Order",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(
                            "No of set you want",
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    // children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: decermentQuantitiy,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                alignment: Alignment.center,
                                height: 29,
                                width: 36,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0xFF91AD13)),
                                child: const Text(
                                  '-',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 29,
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
                                  hintText: quantity.toString(),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 5)),
                            ),
                          ),
                          InkWell(
                            onTap: incrementQuantity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                alignment: Alignment.center,
                                height: 29,
                                width: 36,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0xFF91AD13)),
                                child: const Text(
                                  '+',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext) {
                              return AlertDialog(
                                title: const Text('Order Status'),
                                content: const Text(
                                  'You order has been places sucessfully',
                                  style: TextStyle(color: Colors.green),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(color: Colors.black),
                                      ))
                                ],
                              );
                            });
                      },
                      child: Container(
                        height: 33,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFF91AD13),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: const Center(
                          child: Text(
                            'Order Now',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
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
