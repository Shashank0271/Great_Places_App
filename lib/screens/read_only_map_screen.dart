import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReadOnlyMapScreen extends StatelessWidget {
  final double? latitude;
  final double? longitude;
  const ReadOnlyMapScreen(this.latitude, this.longitude);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(latitude!, longitude!),
        zoom: 15,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('defid'),
          position: LatLng(latitude!, longitude!),
        )
      },
    ));
  }
}
