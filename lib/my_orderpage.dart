import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 55),
            child: Text(
              'Delivery  Status',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 95),
            child: Text(
              '"Serving on best way" ',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 33, vertical: 112),
            child: Container(
              height: 200,
              width: 500,
              child: Image.asset(
                'assets/images/delivery.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 22),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
