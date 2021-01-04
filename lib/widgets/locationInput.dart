import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatPlaces/helpers/locationHelper.dart';
import 'package:greatPlaces/models/coordinates.dart';
import 'package:greatPlaces/screens/mapDisplay.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  LocationData locationData;
  LocationHelper locationHelper;

  Future<void> _getCurrentUserLocation() async {
    locationData = await Location().getLocation();
    locationHelper = LocationHelper(
        cacheLatitude: locationData.latitude,
        cacheLongitude: locationData.longitude);
    final staticMapUrl = locationHelper.generateLocationPreviewImage();

    setState(() {
      _previewImageUrl = staticMapUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapDisplay(
          initialLocation: Coordinates(
              latitude: locationData.latitude,
              longitude: locationData.longitude),
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation != null) {
      print(selectedLocation.latitude);
    }
  }

  @override
  void didChangeDependencies() {
    _getCurrentUserLocation();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          alignment: Alignment.center,
          // decoration: BoxDecoration(
          //   border: Border.all(width: 1, color: Colors.grey),
          // ),
          child: _previewImageUrl == null
              ? CircularProgressIndicator()
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextButton.icon(
            //   onPressed: _getCurrentUserLocation,
            //   icon: Icon(Icons.location_on),
            //   label: Text('Current Location'),
            // ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select On Map'),
            ),
          ],
        )
      ],
    );
  }
}
