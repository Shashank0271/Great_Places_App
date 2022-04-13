import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';
import 'package:great_places_app/screens/places_list_screen.dart';
import 'screens/place_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        theme: ThemeData(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.indigo, accentColor: Colors.amber),
            textTheme: const TextTheme(
              button: TextStyle(color: Colors.black),
            )),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
          PlaceDetailsSCreen.routeName: (context) => const PlaceDetailsSCreen(),
        },
      ),
    );
  }
}
