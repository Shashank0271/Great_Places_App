import 'package:flutter/foundation.dart';
import 'package:great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items {
    return [...items]; //... we get a copt of the list , not the actual list
  }
}
