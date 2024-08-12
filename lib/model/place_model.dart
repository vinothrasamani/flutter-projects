import 'dart:io';

import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceModel {
  PlaceModel({
    required this.placeName,
    required this.image,
    required this.area,
    String? id,
  }) : id = id ?? uuid.v4();

  final String placeName;
  final String id;
  final File image;
  final LatLng area;
}
