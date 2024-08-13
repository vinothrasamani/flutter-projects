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
    final height = MediaQuery.of(context).size.height - 200;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          place.placeName,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: height,
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 2,
                          color:
                              Theme.of(context).appBarTheme.backgroundColor!),
                    ),
                  ),
                  height: height,
                  width: double.infinity,
                  child: MapCreater(
                    tappedLocation: place.area,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(189, 0, 0, 0),
                    ),
                    child: Text(
                      place.addr(),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
