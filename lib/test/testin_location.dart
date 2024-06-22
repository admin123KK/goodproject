import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationPagee extends StatefulWidget {
  const LocationPagee({super.key});

  @override
  State<LocationPagee> createState() => _LocationPageState();
}

BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;

class _LocationPageState extends State<LocationPagee> {
  static LatLng sourceLocation = LatLng(27.69242341891831, 83.46309766111746);
  LatLng destinationLocation = LatLng(27.6798201836189, 83.46561867425898);

  LocationData? currentLocation;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    fetchDestinationLocationFromFirestore();
    setCustomMarkerIcon();
  }

  void getCurrentLocation() async {
    Location location = Location();
    LocationData locationData = await location.getLocation();
    setState(() {
      currentLocation = locationData;
    });
  }

  void fetchDestinationLocationFromFirestore() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('notification')
        .doc('location')
        .get();

    if (snapshot.exists) {
      GeoPoint geoPoint = snapshot['location'];
      setState(() {
        destinationLocation = LatLng(geoPoint.latitude, geoPoint.longitude);
      });
    }
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
            ImageConfiguration.empty, 'assets/images/deliverybike.png')
        .then((icons) {
      currentIcon = icons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF91AD13),
        title: const Text(
          'Delivery Location',
          style: TextStyle(fontFamily: 'Mooli'),
        ),
        centerTitle: true,
      ),
      body: currentLocation == null
          ? const Center(
              child: Text('Loading....'),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
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
                  markerId: MarkerId('currentLocation'),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  icon: destinationIcon,
                  infoWindow: InfoWindow(title: 'Khaja on the way'),
                ),
                Marker(
                  markerId: MarkerId('destinationLocation'),
                  position: destinationLocation,
                  icon: currentIcon,
                  infoWindow: InfoWindow(title: "Delivery Location"),
                ),
              },
            ),
    );
  }
}
