import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class LocationePage extends StatefulWidget {
  const LocationePage({Key? key}) : super(key: key);

  @override
  State<LocationePage> createState() => _LocationePageState();
}

BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;

class _LocationePageState extends State<LocationePage> {
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
    fetchCurrentLocation();
    setCustomMarkerIcon();
  }

  Future<void> fetchCurrentLocation() async {
    try {
      // Fetch initial destination location from Firestore
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('notification')
          .doc('location') // Replace with your document ID
          .get();

      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        String locationName = data['location'];

        // Fetch coordinates from geocoding API based on location name
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

      // Optionally fetch current device location
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
    final apiKey =
        'AIzaSyBD6CkJ6n9blu72_AfP_vx9lO0tvsUYc8s'; // Replace with your API key
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF91AD13),
        title: Text(
          'Delivery Location',
          style: TextStyle(fontFamily: 'Mooli'),
        ),
        centerTitle: true,
      ),
      body: destinationLocation == null
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
            ),
    );
  }
}
