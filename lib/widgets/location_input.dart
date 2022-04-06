import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:typed_data';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

const apiKey = 'AIzaSyBhCqHm1BrofyrPtltsmJ2eu5B7lAkMURs';

class _LocationInputState extends State<LocationInput> {
  String? imageUrl;
  CameraPosition? _cameraPosition;
  GoogleMapController? _mapController;
  Completer<GoogleMapController> _controller = Completer();

  Future<void> _getCurrentLocation() async {
    var locationData = await Location().getLocation();
    var latitude = locationData.latitude as double;
    var longitude = locationData.longitude as double;
    _cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14.4746,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          child: _cameraPosition == null
              ? const Center(child: Text('No location Chosen'))
              : GoogleMap(
                  scrollGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  initialCameraPosition: _cameraPosition!,
                  onMapCreated: (GoogleMapController controller) async {
                    _controller.complete(controller);
                    _mapController = controller;
                  },
                ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on_outlined),
              label: const Text('Current Location'),
            ),
            ElevatedButton.icon(
              onPressed: null,
              icon: const Icon(Icons.map_outlined),
              label: const Text('Current Location'),
            ),
          ],
        )
      ],
    );
  }
}
