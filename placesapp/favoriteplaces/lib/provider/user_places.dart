import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/place.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

Future<sql.Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, name TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)',
      );
    },
    version: 1,
  );

  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super([]);

  Future<void> loadPlaces() async{
    final db = await _getDatabase();

    final data = await db.query('user_places');

    final palces = data.map((row) => Place(
      id: row['id'] as String,
      name: row['name'] as String,
      image: File(row['image'] as String),
      location: PlaceLocation(
        latitude: row['loc_lat'] as double,
        longitude: row['loc_lng'] as double,
        address: row['address'] as String,
      ),
    )).toList();

    state = palces;
  }

  void addPlace(Place place) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(place.image.path);

    final savedImage = await place.image.copy('${appDir.path}/$filename');

    final newPlace = Place(
      name: place.name,
      location: place.location,
      image: savedImage,
    );

    final db = await _getDatabase();

    db.insert(
      'user_places',
      {
        'id': newPlace.id,
        'name': newPlace.name,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location.latitude,
        'loc_lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );

    state = [...state, newPlace];
  }

  /*
  void restorePlace(int index, Place place) async {

    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(place.image.path);

    final savedImage = await place.image.copy('${appDir.path}/$filename');

    final newPlace = Place(
      name: place.name,
      location: place.location,
      image: savedImage,
    );

    final db = await _getDatabase();

    db.insert(
      'user_places',
      {
        'id': newPlace.id,
        'name': newPlace.name,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location.latitude,
        'loc_lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );

    state = [...state]..insert(index, place);
  }
   */

  void removePlace(Place place) async {

    final db = await _getDatabase();

    db.delete(
      'user_places',
      where: 'id = ?',
      whereArgs: [place.id],
    );

    state = [...state]..remove(place);
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());
