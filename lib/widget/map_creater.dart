import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapCreater extends StatefulWidget {
  const MapCreater({
    super.key,
    this.tappedLocation,
    this.handleTap,
    this.isTapable = false,
  });

  final LatLng? tappedLocation;
  final void Function(TapPosition tapPosition, LatLng latlng)? handleTap;
  final bool isTapable;

  @override
  State<MapCreater> createState() {
    return _MapCreaterState();
  }
}

class _MapCreaterState extends State<MapCreater> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FlutterMap(
            options: MapOptions(
              center: widget.tappedLocation,
              zoom: 16,
              maxZoom: 50,
              onTap: widget.isTapable ? widget.handleTap : null,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              if (widget.tappedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: widget.tappedLocation!,
                      builder: (ctx) => Container(
                        margin: const EdgeInsets.all(1),
                        child: const Icon(Icons.location_pin,
                            color: Color.fromARGB(255, 54, 54, 244), size: 40),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
