import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}
