// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Spot {
  String? name;
  String? city;
  String? street;
  String? suburb;
  String? formatted;
  String? place_id;
  List<double>? coordinates;
  Spot({
    required this.name,
    required this.city,
    required this.street,
    required this.suburb,
    required this.formatted,
    required this.place_id,
    required this.coordinates,
  });

  Spot copyWith({
    String? name,
    String? city,
    String? street,
    String? suburb,
    String? formatted,
    String? place_id,
    List<double>? coordinates,
  }) {
    return Spot(
      name: name ?? this.name,
      city: city ?? this.city,
      street: street ?? this.street,
      suburb: suburb ?? this.suburb,
      formatted: formatted ?? this.formatted,
      place_id: place_id ?? this.place_id,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'city': city,
      'street': street,
      'suburb': suburb,
      'formatted': formatted,
      'place_id': place_id,
      'coordinates': coordinates,
    };
  }

  factory Spot.fromMap(Map<String, dynamic> map) {
    return Spot(
      name: map['name'] as String? ?? '',
      city: map['city'] as String? ?? '',
      street: map['street'] as String? ?? '',
      suburb: map['suburb'] as String? ?? '',
      formatted: map['formatted'] as String? ?? '',
      place_id: map['place_id'] as String? ?? '',
      coordinates: List<double>.from((map['coordinates'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Spot.fromJson(String source) =>
      Spot.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Spot(name: $name, city: $city, street: $street, suburb: $suburb, formatted: $formatted, place_id: $place_id, coordinates: $coordinates)';
  }

  @override
  bool operator ==(covariant Spot other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.city == city &&
        other.street == street &&
        other.suburb == suburb &&
        other.formatted == formatted &&
        other.place_id == place_id &&
        listEquals(other.coordinates, coordinates);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        city.hashCode ^
        street.hashCode ^
        suburb.hashCode ^
        formatted.hashCode ^
        place_id.hashCode ^
        coordinates.hashCode;
  }
}
