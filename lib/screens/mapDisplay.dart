import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatPlaces/helpers/locationHelper.dart';

class MapDisplay extends StatefulWidget {
  final LocationHelper locationHelper;
  final bool isSelecting;
  // Coordinates initialLocation;

  MapDisplay({this.locationHelper, this.isSelecting});

  @override
  _MapDisplayState createState() => _MapDisplayState();
}

class _MapDisplayState extends State<MapDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            zoom: 16,
            target: LatLng(widget.locationHelper.cacheLatitude,
                widget.locationHelper.cacheLongitude)),
      ),
    );
  }
}
