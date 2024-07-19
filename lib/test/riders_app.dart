import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class RidersApp extends StatefulWidget {
  const RidersApp({super.key});

  @override
  State<RidersApp> createState() => _RidersAppState();
}

BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;

class _RidersAppState extends State<RidersApp> {
  final TextEditingController _searchController = TextEditingController();
  LocationData? _currentLocation;
  GoogleMapController? _mapController;
  String deliveryLocation = "";
  String orderTime = "";

  LatLng sourceLocation = LatLng(27.69242341891831, 83.46309766111746);
  LatLng initialDestinationLocation = LatLng(27.69242341891831,
      83.46309766111746); // Initial location fetched from Firestore
  LatLng destinationLocation = LatLng(27.69242341891831,
      83.46309766111746); // Initialize destination same as source

  LocationData? currentLocation;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    _getLocation();
    fetchLocation();
    fetchCurrentLocation();
    setCustomMarkerIcon();
  }

  Future<void> fetchLocation() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('notification')
          .where('location', isNotEqualTo: null)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot snapshot = querySnapshot.docs.first;
        var data = snapshot.data() as Map<String, dynamic>;
        print('Fetched data: $data');

        setState(() {
          deliveryLocation = data['location'] ?? 'Location not available';
          Timestamp timestamp = data['dateTime'];
          DateTime dateTime = timestamp.toDate();
          orderTime = DateFormat('hh:mm a').format(dateTime);
        });
      } else {
        setState(() {
          deliveryLocation = 'Document does not exist';
          print('Document does not exist');
        });
      }
    } catch (e) {
      print('Error fetching location: $e');
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

  Future<void> fetchCurrentLocation() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('notification')
          .doc('location') // Replace with your document ID
          .get();

      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        String locationName = data['location'];

        LatLng? coords = await getCoordinatesFromPlaceCode(locationName);
        if (coords != null) {
          setState(() {
            initialDestinationLocation = coords;
            destinationLocation = coords;
          });
        } else {
          print("Failed to convert place code to coordinates.");
        }
      } else {
        print('Document does not exist');
      }

      location.onLocationChanged.listen((LocationData newLoc) {
        setState(() {
          currentLocation = newLoc;
        });
      });
    } catch (e) {
      print('Error fetching current location: $e');
    }
  }

  Future<LatLng?> getCoordinatesFromPlaceCode(String placeCode) async {
    final apiKey = 'AIzaSyBD6CkJ6n9blu72_AfP_vx9lO0tvsUYc8s';
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$placeCode&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          final location = data['results'][0]['geometry']['location'];
          return LatLng(location['lat'], location['lng']);
        } else {
          print("No results found for the place code.");
        }
      } else {
        print("Error fetching coordinates: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during geocoding request: $e");
    }
    return null;
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/store.png',
    ).then((icon) {
      sourceIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/home.png',
    ).then((icons) {
      destinationIcon = icons;
    });
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/deliverybike.png',
    ).then((icons) {
      currentIcon = icons;
    });
  }

  void _startDelivery() {
    if (_currentLocation != null) {
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
            const SizedBox(height: 20),
            Expanded(
              child: destinationLocation == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: initialDestinationLocation,
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId('sourceLocation'),
                          position: sourceLocation,
                          infoWindow: InfoWindow(title: 'Khaja GHar'),
                          icon: sourceIcon,
                        ),
                        Marker(
                          markerId: MarkerId('destinationLocation'),
                          position: destinationLocation,
                          icon: currentIcon,
                          infoWindow: InfoWindow(title: 'Delivery Location'),
                          draggable: true,
                          onDragEnd: (LatLng newLocation) {
                            setState(() {
                              destinationLocation = newLocation;
                            });
                          },
                        ),
                        if (currentLocation != null)
                          Marker(
                            markerId: MarkerId('currentLocation'),
                            position: LatLng(
                              currentLocation!.latitude!,
                              currentLocation!.longitude!,
                            ),
                            infoWindow: InfoWindow(title: 'Current Location'),
                            icon: destinationIcon,
                          ),
                      },
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
