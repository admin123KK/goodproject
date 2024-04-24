import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PhiniPage extends StatefulWidget {
  const PhiniPage({super.key});

  @override
  State<PhiniPage> createState() => _PhiniPageState();
}

class _PhiniPageState extends State<PhiniPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/phini.png',
            fit: BoxFit.cover,
          ),
          Container(
            height: 350,
            width: 420,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 32, 24, 24),
                  Colors.transparent,
                  Color.fromARGB(255, 37, 28, 28)
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
                padding: const EdgeInsets.symmetric(vertical: 33),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  color: Colors.white,
                  iconSize: 30,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.shopping_cart_checkout_outlined),
                      color: Colors.white,
                      iconSize: 30,
                    ),
                  ),
                ],
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
                                fontSize: 38),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  RatingBar.builder(
                                    initialRating: 3,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
