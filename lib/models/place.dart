import 'package:flutter/cupertino.dart';
import 'dart:io';

class Place {
  final String? id;
  final String? title;
  final latitude;
  final longitude;
  final address;
  final File? image;
  Place({
    @required this.id,
    @required this.title,
    @required this.image,
    this.latitude,
    this.longitude,
    this.address,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'image': image!.path,
      };
}
