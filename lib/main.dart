import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:great_places_app/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:great_places_app/screens/places_list_screen.dart';
import 'models/spot.dart';
import 'screens/place_detail_screen.dart';
import 'screens/show_spots_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
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
        home: const HomePage(),
        routes: {
          PlacesListScreen.routeName: (context) => const PlacesListScreen(),
          AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
          PlaceDetailsSCreen.routeName: (context) => const PlaceDetailsSCreen(),
          ShowSpotsScreen.routeName: (context) {
            final placesList = ModalRoute.of(context)!.settings.arguments as List<Spot>;
            return ShowSpotsScreen(places: placesList );
          }
        },
      ),
    );
  }
}
