import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];
  List<Place> get items {
    return [..._items]; //... we get a copt of the list , not the actual list
  }

  void addPlace(String title, File imageFile) {
    final newPlace = Place(
      title: title,
      image: imageFile,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}
