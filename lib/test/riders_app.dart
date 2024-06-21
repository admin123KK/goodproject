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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/delivery.png',
              height: 200,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Delivery Location :',
                  style: TextStyle(
                      fontFamily: 'Mooli', fontWeight: FontWeight.bold),
                ),
                Text(' $deliveryLocation'),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Order Time :',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Mooli'),
                ),
                Text(' $orderTime'),
              ],
            ),
            const Row(
              children: [
                Text(
                  'Order Items :',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Mooli'),
                ),
                Text(''),
                SizedBox(
                  width: 29,
                ),
                Text('Order Qunatity'),
                SizedBox(
                  width: 29,
                ),
                const Text('Total Cost ')
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Delivery Details',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startDelivery,
              child: Text('Start Delivery'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF91AD13),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _currentLocation == null
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          _currentLocation!.latitude!,
                          _currentLocation!.longitude!,
                        ),
                        zoom: 15,
                      ),
                      onMapCreated: (controller) {
                        _mapController = controller;
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
