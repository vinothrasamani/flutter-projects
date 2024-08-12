import 'dart:io';

import 'package:favorite_places/model/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

Future<Database> _getDB() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, name TEXT, image TEXT, lat REAL, lng REAL)',
      );
    },
    version: 1,
  );
  return db;
}

class PlaceProviderNotifier extends StateNotifier<List<PlaceModel>> {
  PlaceProviderNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDB();
    final data = await db.query('user_places');
    final places = data.map(
      (row) {
        return PlaceModel(
          id: row['id'] as String,
          placeName: row['name'] as String,
          image: File(row['image'] as String),
          area: LatLng(
            row['lat'] as double,
            row['lng'] as double,
          ),
        );
      },
    ).toList();

    state = places;
  }

  Future<void> addPlace(PlaceModel place) async {
    final db = await _getDB();
    await db.insert('user_places', {
      'id': place.id,
      'name': place.placeName,
      'image': place.image.path,
      'lat': place.area.latitude,
      'lng': place.area.longitude,
    });

    state = [place, ...state];
  }
}

final placeProvider =
    StateNotifierProvider<PlaceProviderNotifier, List<PlaceModel>>(
  (ref) => PlaceProviderNotifier(),
);
