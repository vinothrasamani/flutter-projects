import 'package:favorite_places/widget/map_creater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapInput extends StatefulWidget {
  const MapInput({
    super.key,
    required this.onselect,
  });

  final void Function(LatLng place) onselect;

  @override
  State<MapInput> createState() {
    return _MapInputState();
  }
}

class _MapInputState extends State<MapInput> {
  bool _isloading = false;
  LatLng? currentLocation;
  LatLng? tappedLocation;

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isloading = true;
    });

    // Check for location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Handle permission denial
        return;
      }
    }

    // Get the current location of the device
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      tappedLocation = currentLocation;
      if (tappedLocation == null) return;
      widget.onselect(tappedLocation!);
      _isloading = false;
    });
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      tappedLocation = latlng;
      if (tappedLocation == null) return;
      widget.onselect(tappedLocation!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = IconButton.filledTonal(
      onPressed: _getCurrentLocation,
      icon: const Icon(
        Icons.location_on_rounded,
        size: 30,
      ),
    );

    if (_isloading) {
      content = const SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      );
    }

    if (currentLocation != null) {
      content = MapCreater(
        tappedLocation: tappedLocation,
        handleTap: _handleTap,
        isTapable: true,
      );
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 22, 23, 22),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).appBarTheme.backgroundColor!,
            ),
          ),
          height: 300,
          width: double.infinity,
          child: content,
        ),
      ],
    );
  }
}
