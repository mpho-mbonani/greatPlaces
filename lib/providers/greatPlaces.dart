import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:greatPlaces/helpers/dbHelper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: null,
        image: image);
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DbHelper.getData('places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              image: File(item['image']),
              location: null,
              title: item['title'],
            ))
        .toList();
    notifyListeners();
  }
}
