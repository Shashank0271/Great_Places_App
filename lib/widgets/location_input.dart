import 'package:flutter/material.dart';
import 'package:great_places_app/screens/map_screen.dart';
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
  // final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _mapController;
  Set<Marker> markerSet = {};
  late double latitude, longitude;

  void _moveCamToPos(double latitude, double longitude) {
    var newPosition =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 15);
    CameraUpdate update = CameraUpdate.newCameraPosition(newPosition);
    _mapController!.moveCamera(update);
  }

  Future<void> _getCurrentLocation() async {
    var locationData = await Location().getLocation();
    latitude = locationData.latitude as double;
    longitude = locationData.longitude as double;
    _cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14.4746,
    );
    markerSet = {
      Marker(
        markerId: const MarkerId('home'),
        position: LatLng(latitude, longitude),
      )
    };
    setState(() {
      if (_mapController != null) {
        _moveCamToPos(latitude, longitude);
      }
    });
  }

  void updateLocSnap() async {
    final LatLng returnedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return MapScreen(
            latitude: latitude,
            longitude: longitude,
          );
        },
      ),
    );
    setState(() {
      latitude = returnedLocation.latitude;
      longitude = returnedLocation.longitude;

      markerSet = {
        Marker(
            markerId: const MarkerId("id"),
            position: LatLng(latitude, longitude))
      };
      _moveCamToPos(latitude, longitude);
    });
  }

  @override
  void initState() {
    super.initState();
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
                  markers: markerSet,
                  initialCameraPosition: _cameraPosition!,
                  onMapCreated: (GoogleMapController controller) async {
                    // _controller.complete(controller);
                    _mapController = controller;
                  },
                ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on_outlined),
              label: const Text('Current Location'),
            ),
            ElevatedButton.icon(
              onPressed: updateLocSnap,
              icon: const Icon(Icons.map_outlined),
              label: const Text('Select on Map'),
            ),
          ],
        )
      ],
    );
  }
}
