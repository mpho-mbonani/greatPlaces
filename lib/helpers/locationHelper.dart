import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyDQbZ72mMLvPF2ZZ00zGaiwTqu-5ZI6Jn4';

class LocationHelper {
  final double cacheLatitude;
  final double cacheLongitude;

  LocationHelper({this.cacheLatitude, this.cacheLongitude});

  String generateLocationPreviewImage() {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$cacheLatitude,$cacheLongitude&zoom=15&size=600x300&maptype=roadmap&markers=color:red%7Clabel:o%7C$cacheLatitude,$cacheLongitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY";
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
