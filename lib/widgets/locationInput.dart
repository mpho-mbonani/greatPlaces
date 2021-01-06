import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatPlaces/helpers/locationHelper.dart';
import 'package:greatPlaces/models/coordinates.dart';
import 'package:greatPlaces/screens/mapDisplay.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  LocationData locationData;
  LocationHelper locationHelper;

  void _showPreview(double lat, double lng) {
    // supplying variables to helper
    locationHelper = LocationHelper(
        cacheLatitude: locationData.latitude,
        cacheLongitude: locationData.longitude);

    // running with previously supplied variables
    final staticMapUrl = locationHelper.generateLocationPreviewImage();

    setState(() {
      _previewImageUrl = staticMapUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      locationData = await Location().getLocation();
      _showPreview(null, null);
      widget.onSelectPlace(locationData.latitude, locationData.longitude);
    } catch (error) {
      return;
    }
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
      _showPreview(null, null);
      widget.onSelectPlace(
          selectedLocation.latitude, selectedLocation.longitude);
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
