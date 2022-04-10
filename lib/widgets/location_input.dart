// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:great_places_app/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function selectLocation;
  const LocationInput(
    this.selectLocation,
  );

  @override
  State<LocationInput> createState() => _LocationInputState();
}

const apiKey = 'AIzaSyBhCqHm1BrofyrPtltsmJ2eu5B7lAkMURs';

class _LocationInputState extends State<LocationInput> {
  String? imageUrl;
  CameraPosition? _cameraPosition;
  GoogleMapController? _mapController;
  Set<Marker> markerSet = {};
  double? _latitude, _longitude;

  void _moveCamToPos(double latitude, double longitude) {
    var newPosition =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 15);
    CameraUpdate update = CameraUpdate.newCameraPosition(newPosition);
    _mapController!.moveCamera(update);
  }

  Future<void> getCurrentCoordinates() async {
    var locationData = await Location().getLocation();
    _latitude = locationData.latitude as double;
    _longitude = locationData.longitude as double;
  }

  Future<void> _currentLocation() async {
    await getCurrentCoordinates();
    _cameraPosition = CameraPosition(
      target: LatLng(_latitude!, _longitude!),
      zoom: 14.4746,
    );
    markerSet = {
      Marker(
        markerId: const MarkerId('home'),
        position: LatLng(_latitude!, _longitude!),
      )
    };
    setState(() {
      widget.selectLocation(_latitude, _longitude);
      if (_mapController != null) {
        _moveCamToPos(_latitude!, _longitude!);
      }
    });
  }

  void updateLocSnap() async {
    //after selecting from map
    if (_latitude == null) {
      await getCurrentCoordinates();
    }
    final LatLng returnedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return MapScreen(
            latitude: _latitude!,
            longitude: _longitude!,
          );
        },
      ),
    );
    setState(() {
      _latitude = returnedLocation.latitude;
      _longitude = returnedLocation.longitude;
      widget.selectLocation(_latitude, _longitude);
      markerSet = {
        Marker(
            markerId: const MarkerId("id"),
            position: LatLng(_latitude!, _longitude!))
      };
      if (_mapController != null) {
        _moveCamToPos(_latitude!, _longitude!);
      } else {
        _cameraPosition = _cameraPosition = CameraPosition(
          target: LatLng(_latitude!, _longitude!),
          zoom: 14.4746,
        );
      }
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
              : ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: GoogleMap(
                    scrollGesturesEnabled: false,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: false,
                    markers: markerSet,
                    initialCameraPosition: _cameraPosition!,
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                  ),
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
              onPressed: _currentLocation,
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
