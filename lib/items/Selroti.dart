import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelRotiPage extends StatefulWidget {
  const SelRotiPage({super.key});

  @override
  State<SelRotiPage> createState() => _SelRotiPageState();
}

class _SelRotiPageState extends State<SelRotiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/selroti.png',
            fit: BoxFit.cover,
          ),
          Container(
            height: 400,
            width: 450,
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
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart_checkout,
                      color: Color(0xFF91AD13),
                      size: 29,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 380),
            child: Container(
              height: 300,
              width: 450,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: EdgeInsets.all(11.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SelRoti',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Mooli',
                          fontWeight: FontWeight.bold),
                    ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Rs.60',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                        // SizedBox(
                        //   height: 2,
                        // ),
                        Text('/per piece')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
