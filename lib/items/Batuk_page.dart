import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BatukPage extends StatefulWidget {
  const BatukPage({super.key});

  @override
  State<BatukPage> createState() => _BatukPageState();
}

class _BatukPageState extends State<BatukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: InkWell(
                  child: IconButton(
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
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
