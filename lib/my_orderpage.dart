import 'dart:async';

import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool orderReceived = true;
  bool orderPacked = false;
  bool orderOnWay = false;
  bool orderDeliverd = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(Duration(seconds: 5), () {
      setState(() {
        orderReceived = false;
        orderPacked = true;
      });

      Timer(Duration(seconds: 3), () {
        setState(() {
          orderPacked = false;
          orderOnWay = true;
        });

        Timer(Duration(seconds: 6), () {
          setState(() {
            orderOnWay = false;
            orderDeliverd = true;
          });
        });
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 24,
                        color: Colors.black,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Delivery Status',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 33),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '"Serving simple and fast"',
                      style: TextStyle(
                          color: Colors.grey[600], fontFamily: 'Mooli'),
                    ),
                  ),
                ),
                Container(
                  height: 230,
                  width: 400,
                  child: Image.asset('assets/images/delivery.png'),
                ),
                Container(
                  child: const Text(
                    'TimeLine of Your Order',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 150,
                    width: 300,
                    child: Column(
                      children: [
                        _buildIcon(Icons.receipt_long_sharp, 'Received',
                            orderReceived),
                        Container(
                          height: 30,
                          child: const VerticalDivider(
                              thickness: 2, color: Colors.grey),
                        ),
                        _buildIcon(
                            Icons.assignment_turned_in, 'Packed', orderPacked),
                        Container(
                          height: 30,
                          child: const VerticalDivider(
                              color: Colors.grey, thickness: 2),
                        ),
                        _buildIcon(Icons.delivery_dining_rounded, 'On the way',
                            orderOnWay),
                        Container(
                          height: 30,
                          child: const VerticalDivider(
                              thickness: 2, color: Colors.grey),
                        ),
                        _buildIcon(Icons.done, 'Deliverd', orderDeliverd),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

Widget _buildIcon(IconData icon, String status, bool isCurrent) {
  return Column(
    children: [
      Icon(icon, size: 50, color: isCurrent ? Color(0xFF91AD13) : Colors.black),
      Text(
        status,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'MOoli'),
      )
    ],
  );
}
