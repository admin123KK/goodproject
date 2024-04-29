import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

List<LatLng> polyLinesCoordinates = [];
LocationData? currentLocation;

void getCurrentLocation() {
  Location location = Location();
  location.getLocation().then((location) {
    currentLocation = location;
  });
}

BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
BitmapDescriptor current = BitmapDescriptor.defaultMarker;

class _LocationPageState extends State<LocationPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static LatLng sourceLocation = LatLng(27.69242341891831, 83.46309766111746);
  static LatLng destinationLocation =
      LatLng(27.6798201836189, 83.46561867425898);

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      AutofillHints.addressCity,
      PointLatLng(sourceLocation.latitude, destinationLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polyLinesCoordinates.add(LatLng(point.latitude, point.longitude)));
      setState(() {});
    }
  }

  @override
  void initState() {
    getPolyPoints();
    getCurrentLocation();
    setCustomMarkerIcon();
    super.initState();
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/store.png',
    ).then((icon) {
      sourceIcon = icon;
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
              child: Text(
              'Loading',
            ))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 15,
              ),
              polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  points: polyLinesCoordinates,
                )
              },
              markers: {
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  infoWindow: InfoWindow(title: 'Khaja on the way'),
                  icon: sourceIcon,
                ),
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: sourceLocation,
                  infoWindow: InfoWindow(title: 'Khaja GHar'),
                  icon: sourceIcon,
                ),
                Marker(
                  markerId: MarkerId('destinationLocation'),
                  position: destinationLocation,
                  infoWindow: InfoWindow(title: "Delivery Location"),
                ),
              },
            ),
    );
  }
}
