import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goodproject/verifypages/location_page.dart';

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
  String deliveryLocation = "";

  @override
  void initState() {
    super.initState();
    startTimer();
    fetchLocation();
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

  Future<void> fetchLocation() async {
    try {
      // Query the collection to find the document with the desired field
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('notification')
          .where('location',
              isNotEqualTo: null) // Adjust this condition as needed
          .limit(1) // Assuming you want only the first document that matches
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot snapshot = querySnapshot.docs.first;
        var data = snapshot.data() as Map<String, dynamic>;
        print('Fetched data: $data'); // Debugging line

        setState(() {
          deliveryLocation = data['location'] ?? 'Location not available';
          print('Delivery location set: $deliveryLocation'); // Debugging line
        });
      } else {
        setState(() {
          deliveryLocation = 'Document does not exist';
          print('Document does not exist'); // Debugging line
        });
      }
    } catch (e) {
      print('Error fetching location: $e'); // Debugging line
      setState(() {
        deliveryLocation = 'Error fetching location';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.black,
                          size: 27,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Delivery Status',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 43),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '"Serving simple and fast"',
                    style:
                        TextStyle(color: Colors.grey[600], fontFamily: 'Mooli'),
                  ),
                ),
              ),
              Container(
                height: 170,
                width: 300,
                child: Image.asset('assets/images/delivery.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: const Text(
                      'TimeLine of Your Order',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(
                          'Delivery Location:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontFamily: 'Mooli'),
                        ),
                        Text(' $deliveryLocation'),
                      ],
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Order Time :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'Mooli'),
                  ),
                  Text('  9.10')
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Delivery Time :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'Mooli'),
                  ),
                  Text(' 15 min (Approx)')
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Container(
                  height: 70,
                  width: 300,
                  child: Column(
                    children: [
                      _buildIcon(
                          Icons.receipt_long_sharp, 'Received ', orderReceived),
                      Container(
                        height: 30,
                        child: const VerticalDivider(
                            thickness: 2, color: Colors.grey),
                      ),
                      _buildIcon(Icons.assignment_turned_in, 'Packed (6 min)',
                          orderPacked),
                      Container(
                        height: 30,
                        child: const VerticalDivider(
                            color: Colors.grey, thickness: 2),
                      ),
                      _buildIcon(Icons.delivery_dining_rounded,
                          'On the way (10 min)', orderOnWay),
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
              const Text('OR'),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF91AD13),
                          ),
                        );
                      });
                  Timer(Duration(seconds: 2), () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationPage()));
                  });
                },
                child: Container(
                  height: 30,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27),
                    color: const Color(0xFF91AD13),
                  ),
                  child: const Center(
                      child: Text(
                    'Track Live Location ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildIcon(IconData icon, String status, bool isCurrent) {
  return Column(
    children: [
      Icon(icon, size: 50, color: isCurrent ? Color(0xFF91AD13) : Colors.black),
      Text(
        status,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Mooli',
            color: isCurrent ? const Color(0xFF91AD13) : Colors.black),
      )
    ],
  );
}
