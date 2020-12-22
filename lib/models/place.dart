import 'dart:io';

import 'package:flutter/foundation.dart';
import 'coordinates.dart';

class Place {
  final String id;
  final String title;
  final Coordinates location;
  final File image;

  Place(
      {@required this.id,
      @required this.title,
      @required this.location,
      @required this.image});
}
