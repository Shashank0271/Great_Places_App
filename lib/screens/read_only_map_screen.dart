import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ReadOnlyMapScreen extends StatefulWidget {
  final double? latitude;
  final double? longitude;

  const ReadOnlyMapScreen(this.latitude, this.longitude);

  @override
  State<ReadOnlyMapScreen> createState() => _ReadOnlyMapScreenState();
}

class _ReadOnlyMapScreenState extends State<ReadOnlyMapScreen> {
  double? _srclatitude;
  double? _srclongitude;

  Future<void> getCurrentCoordinates() async {
    var locationData = await Location().getLocation();
    _srclatitude = locationData.latitude as double;
    _srclongitude = locationData.longitude as double;
  }

  @override
  void initState() {
    super.initState();
    getCurrentCoordinates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.latitude!, widget.longitude!),
        zoom: 15,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('defid'),
          position: LatLng(widget.latitude!, widget.longitude!),
        )
      },
    ));
  }
}
