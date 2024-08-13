import 'dart:io';

import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceModel {
  PlaceModel({
    required this.placeName,
    required this.image,
    required this.area,
    String? id,
    this.address = 'Unknown Address',
  }) : id = id ?? uuid.v4();

  final String placeName;
  final String id;
  final File image;
  final LatLng area;
  String address;

  String addr() {
    getAddressFromLatLng();
    return address;
  }

  Future<void> getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        area.latitude,
        area.longitude,
      );

      Placemark place = placemarks[0];
      address =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      address = "Unknown location";
    }
  }
}
