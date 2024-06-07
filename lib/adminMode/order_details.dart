import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF91AD13),
        centerTitle: true,
        title: const Text(
          'Order Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Mooli',
          ),
        ),
      ),
    );
  }
}
