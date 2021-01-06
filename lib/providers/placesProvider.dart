import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:greatPlaces/helpers/dbHelper.dart';
import 'package:greatPlaces/helpers/locationHelper.dart';
import 'package:greatPlaces/models/coordinates.dart';
import '../models/place.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get items {
    return [..._places];
  }

  Place findById(String id) {
    return _places.firstWhere((x) => x.id == id);
  }

  Future<void> addPlace(String title, File image, Coordinates location) async {
    final address = await LocationHelper.getPlaceAddress(
        location.latitude, location.longitude);

    final updatedLocation = Coordinates(
        latitude: location.latitude,
        longitude: location.longitude,
        address: address);

    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: updatedLocation,
        image: image);
    _places.add(newPlace);
    notifyListeners();
    DbHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'locationLatitude': newPlace.location.latitude,
      'locationLongitude': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DbHelper.getData('places');
    _places = dataList
        .map((item) => Place(
              id: item['id'],
              image: File(item['image']),
              location: Coordinates(
                  latitude: item['locationLatitude'],
                  longitude: item['locationLongitude'],
                  address: item['address']),
              title: item['title'],
            ))
        .toList();
    notifyListeners();
  }
}
