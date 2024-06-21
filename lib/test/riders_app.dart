import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class RidersApp extends StatefulWidget {
  const RidersApp({super.key});

  @override
  State<RidersApp> createState() => _RidersAppState();
}

class _RidersAppState extends State<RidersApp> {
  final TextEditingController _searchController = TextEditingController();
  LocationData? _currentLocation;
  GoogleMapController? _mapController;
  String deliveryLocation = "";
  String orderTime = "";

  @override
  void initState() {
    super.initState();
    _getLocation();
    fetchLocation();
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
          // orderTime = (data['dateTime'] as Timestamp).toDate().toString();
          Timestamp timestamp = data['dateTime'];
          DateTime dateTime = timestamp.toDate();
          orderTime = DateFormat('hh:mm a').format(dateTime);
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

  Future<void> _getLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentLocation = await location.getLocation();
    setState(() {});
  }

  void _startDelivery() {
    if (_currentLocation != null) {
      // Implement logic to share the location or start the delivery process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Starting delivery from ${_currentLocation!.latitude}, ${_currentLocation!.longitude}')),
      );
    }
  }

  Stream<QuerySnapshot> getOrderItemStream() {
    return FirebaseFirestore.instance.collection('notification').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF91AD13),
        centerTitle: true,
        title: const Text(
          'KhajaGhar Riders',
          style: TextStyle(
            fontFamily: 'Mooli',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Image.asset(
              'assets/images/delivery.png',
              height: 200,
            ),
            Text('(Order Details)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Delivery Location :',
                  style: TextStyle(
                      fontFamily: 'Mooli', fontWeight: FontWeight.bold),
                ),
                Text(' $deliveryLocation'),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Order Time :',
                  style: TextStyle(
                      fontFamily: 'Mooli', fontWeight: FontWeight.bold),
                ),
                Text(' $orderTime')
              ],
            ),
            Container(
              height: 90,
              width: 430,
              child: StreamBuilder<QuerySnapshot>(
                stream: getOrderItemStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data'));
                  }
                  final orders = snapshot.data?.docs ?? [];
                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final orderData =
                          orders[index].data() as Map<String, dynamic>;
                      final itemName = orderData['itemName'] ?? 'N/A';
                      final quantity = orderData['quantity'] ?? 'N/A';
                      final totalCost = orderData['totalCost'] ?? 'N/A';
                      final userName = orderData['Name'] ?? 'N/A';
                      final cashPay = orderData['cashPay'] ?? 'Online paid';

                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Item :$itemName'),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Quantity: $quantity'),
                          ],
                        ),
                        trailing: Column(
                          children: [
                            Text(
                              'Delivery To: $userName',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 13),
                            ),
                            Text(
                              'CashPay : $cashPay',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Text(
                              'Total Cost: $totalCost',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // TextField(
            //   controller: _searchController,
            //   decoration: const InputDecoration(
            //     labelText: 'Search Delivery Details',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: _startDelivery,
            //   child: Text('Start Delivery'),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: const Color(0xFF91AD13),
            //   ),
            // ),
            // const SizedBox(height: 20),
            // Expanded(
            //   child: _currentLocation == null
            //       ? const Center(child: CircularProgressIndicator())
            //       : GoogleMap(
            //           initialCameraPosition: CameraPosition(
            //             target: LatLng(
            //               _currentLocation!.latitude!,
            //               _currentLocation!.longitude!,
            //             ),
            //             zoom: 15,
            //           ),
            //           onMapCreated: (controller) {
            //             _mapController = controller;
            //           },
            //           myLocationEnabled: true,
            //           myLocationButtonEnabled: true,
            //         ),
            // ),
          ],
        ),
      ),
    );
  }
}
