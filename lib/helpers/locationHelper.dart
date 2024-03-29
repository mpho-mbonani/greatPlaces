import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyDQbZ72mMLvPF2ZZ00zGaiwTqu-5ZI6Jn4';

class LocationHelper {
  static String generateLocationPreviewImage(double lat, double lng) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$lat,$lng&zoom=15&size=600x300&maptype=roadmap&markers=color:red%7Clabel:o%7C$lat,$lng&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    try {
      final url =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY";
      final response = await http.get(url);
      return json.decode(response.body)['results'][0]['formatted_address'];
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
