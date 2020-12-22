import 'package:flutter/material.dart';
import 'package:greatPlaces/helpers/locationHelper.dart';
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
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapDisplay(
          locationHelper: locationHelper,
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation != null) {}
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
                  fit: BoxFit.cover,
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
              label: Text('Select Location'),
            ),
          ],
        )
      ],
    );
  }
}
