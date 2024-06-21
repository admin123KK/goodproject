import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  TextEditingController _searchController = TextEditingController();
  Position? _currentPosition;
  Marker? _destinationMarker;
  List<LatLng> _polylineCoordinates = [];
  PolylinePoints _polylinePoints = PolylinePoints();
  String _googleApiKey = 'AIzaSyDZ73jAKJLALZtLH8nUGEaRupO2f1MlboQ';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }

  Future<void> _searchLocation() async {
    String query = _searchController.text;
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$query&key=$_googleApiKey'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        var location = data['results'][0]['geometry']['location'];
        LatLng latLng = LatLng(location['lat'], location['lng']);
        _addMarker(latLng);
        if (_currentPosition != null) {
          await _getPolyline(_currentPosition!, latLng);
        }
      } else {
        print('No results found');
      }
    } else {
      throw Exception('Failed to load location');
    }
  }

  void _addMarker(LatLng position) {
    setState(() {
      _destinationMarker = Marker(
        markerId: MarkerId('destination'),
        position: position,
      );
    });
    _controller?.animateCamera(CameraUpdate.newLatLngZoom(position, 14));
  }

  Future<void> _getPolyline(Position start, LatLng destination) async {
    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      _googleApiKey,
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      setState(() {
        _polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
    }
  }

  void _startDelivery() {
    if (_currentPosition != null && _destinationMarker != null) {
      _getPolyline(_currentPosition!, _destinationMarker!.position);
      print(
          'Start delivery from ${_currentPosition!.latitude}, ${_currentPosition!.longitude} to ${_destinationMarker!.position.latitude}, ${_destinationMarker!.position.longitude}');
    } else {
      print('Current position or destination is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: Stack(
        children: [
          _currentPosition == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_currentPosition!.latitude,
                        _currentPosition!.longitude),
                    zoom: 14,
                  ),
                  markers:
                      _destinationMarker != null ? {_destinationMarker!} : {},
                  polylines: {
                    Polyline(
                      polylineId: PolylineId('route'),
                      points: _polylineCoordinates,
                      color: Colors.blue,
                      width: 6,
                    )
                  },
                  onMapCreated: (controller) {
                    _controller = controller;
                  },
                  myLocationEnabled: true,
                ),
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Enter Plus Code',
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _searchLocation,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                if (_destinationMarker != null)
                  ElevatedButton(
                    onPressed: _startDelivery,
                    child: Text('Get Directions and Start Delivery'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
