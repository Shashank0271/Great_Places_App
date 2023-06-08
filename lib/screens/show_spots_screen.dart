import 'package:flutter/material.dart';
import 'package:great_places_app/models/spot.dart';
import 'package:great_places_app/screens/spot_details_screen.dart';

class ShowSpotsScreen extends StatelessWidget {
  static const routeName = '/show_spots_screen';
  List<Spot> places;
  ShowSpotsScreen({required this.places});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: places.length,
                itemBuilder: (context, index) {
                  final place = places[index];
                  return ListTile(
                      title: Text(place.name!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(place.city!), Text(place.suburb!)],
                      ),
                      leading: const Icon(Icons.location_city),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SpotDetailsScreen(spot: place)));
                      });
                })));
  }
}
