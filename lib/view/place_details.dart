import 'package:favorite_places/model/place_model.dart';
import 'package:favorite_places/widget/map_creater.dart';
import 'package:flutter/material.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({
    super.key,
    required this.place,
  });

  final PlaceModel place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.placeName),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: 2,
                      color: Theme.of(context).appBarTheme.backgroundColor!),
                ),
              ),
              height: 250,
              width: double.infinity,
              child: MapCreater(
                tappedLocation: place.area,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
