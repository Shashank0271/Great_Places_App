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
  Uint8List? _imageBytes;
  Completer<GoogleMapController> _controller = Completer();

  Future<void> _getCurrentLocation() async {
    var locationData = await Location().getLocation();
    var latitude = locationData.latitude as double;
    var longitude = locationData.longitude as double;
    _cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14.4746,
    );

    // GoogleMap(
    //   initialCameraPosition: _cameraPosition!,
    //   onMapCreated: (GoogleMapController controller) {
    //     _controller.complete(controller);
    //     _mapController = controller;
    //   },
    // );
    //newb comment

    Uint8List? imageBytes = await _mapController?.takeSnapshot();
    setState(() {
      _imageBytes = imageBytes;
    });
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 0,
          width: double.infinity,
          child: _cameraPosition == null
              ? const Center(child: Text('No location Chosen'))
              : GoogleMap(
                  initialCameraPosition: _cameraPosition!,
                  onMapCreated: (GoogleMapController controller) async {
                    _controller.complete(controller);
                    _mapController = controller;
                    Uint8List? imageBytes = await controller.takeSnapshot();
                    setState(() {
                      _imageBytes = imageBytes;
                    });
                  },
                ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 200,
          child: _imageBytes != null
              ? Image.memory(_imageBytes!)
              : const Center(
                  child: CircularProgressIndicator(),
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
