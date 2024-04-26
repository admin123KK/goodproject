import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ChukauniPage extends StatefulWidget {
  const ChukauniPage({super.key});

  @override
  State<ChukauniPage> createState() => _ChukauniPageState();
}

class _ChukauniPageState extends State<ChukauniPage> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
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
        width: 420,
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
              padding: EdgeInsets.symmetric(vertical: 28, horizontal: 9),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart_checkout,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
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
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 33),
                          child: Text(
                            'Chukauni',
                            style: TextStyle(
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
                                    const Text(
                                      '3 Star Rating',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  ],
                                ),
                                const Column(
                                  children: [
                                    Text(
                                      'Rs.50',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 2, 99, 6),
                                          fontSize: 27),
                                    ),
                                    Text('   /per set '),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "Chukauni is a traditional Nepali dish, particularly popular in the Newari community of Nepal. It is made from boiled potatoes, typically cut into cubes, and then mixed with a spicy yogurt-based sauce. The sauce is usually flavored with mustard oil, fenugreek seeds, turmeric, and other spices.It's known for its tangy and spicy taste, making it a favorite among many Nepali food lovers.",
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
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "Customize you Order",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Text("No of set you want"),
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
                                      focusColor: Color(0xFF91AD13),
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
                                      hintText: quantity.toString(),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 5)),
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
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
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
                                        return AlertDialog(
                                          title: const Text('Order Status'),
                                          content: const Text(
                                            'Your order has been placed sucessufully',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'OK',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 33,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF91AD13),
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                  child: const Text(
                                    'Order Now',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
