import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

const apiKey = 'AIzaSyBhCqHm1BrofyrPtltsmJ2eu5B7lAkMURs';

class _LocationInputState extends State<LocationInput> {
  String? imageUrl;
  CameraPosition? _cameraPosition;

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
    Completer<GoogleMapController> _controller = Completer();
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          child: _cameraPosition == null
              ? const Center(child: Text('No location Chosen'))
              : GoogleMap(
                  initialCameraPosition: _cameraPosition!,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 20),
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
