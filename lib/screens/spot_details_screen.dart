import 'package:flutter/material.dart';
import 'package:great_places_app/screens/map_screen.dart';

import '../models/spot.dart';

class SpotDetailsScreen extends StatelessWidget {
  final Spot spot;

  SpotDetailsScreen({required this.spot});

  @override
  Widget build(BuildContext context) {
    String name = spot.name!;
    String city = spot.city!;
    String street = spot.street!;
    String suburb = spot.suburb!;
    String formatted = spot.formatted!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Details'),
      ),
      body: Center(
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text('City: $city'),
                Text('Street: $street'),
                Text('Suburb: $suburb'),
                const SizedBox(height: 10),
                const Text(
                  'Location Address:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(formatted),
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapScreen(
                                  longitude: spot.coordinates![0],
                                  latitude: spot.coordinates![1])));
                    },
                    icon: const Icon(Icons.map_outlined),
                    label: const Text("View on map"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
