import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final LatLng initialLocation;
  final String destination;

  const MapWidget({required this.initialLocation, required this.destination});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
        setState(() {
          mapController = controller;
        });
      },
      initialCameraPosition: CameraPosition(
        target: widget.initialLocation,
        zoom: 12,
      ),
      markers: {
        Marker(
          markerId: MarkerId('destination'),
          position: widget.initialLocation,
          infoWindow: InfoWindow(title: widget.destination),
        ),
      },
    );
  }
}