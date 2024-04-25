import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChukauniPage extends StatefulWidget {
  const ChukauniPage({super.key});

  @override
  State<ChukauniPage> createState() => _ChukauniPageState();
}

class _ChukauniPageState extends State<ChukauniPage> {
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
              padding: EdgeInsets.symmetric(vertical: 28),
              child: Icon(
                Icons.arrow_back,
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
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            'Chukaune',
                            style: TextStyle(
                                fontFamily: 'Mooli',
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ])));
  }
}
