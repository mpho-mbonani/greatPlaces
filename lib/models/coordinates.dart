import 'package:flutter/foundation.dart';

class Coordinates {
  final double latitude;
  final double longitude;
  final String address;

  const Coordinates(
      {@required this.latitude, @required this.longitude, this.address});
}
