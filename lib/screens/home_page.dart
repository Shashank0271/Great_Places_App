import 'package:flutter/material.dart';
import 'package:great_places_app/screens/getTouristSpots.dart';
import 'package:great_places_app/screens/places_list_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Great Places App'),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.add_a_photo_rounded)),
                Tab(icon: Icon(Icons.travel_explore)),
              ],
            )),
        body: const TabBarView(children: [
          PlacesListScreen(),
          TouristSpots(),
        ]),
      ),
    );
  }
}
