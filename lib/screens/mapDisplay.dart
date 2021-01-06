import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDisplay extends StatefulWidget {
  final double currentLatitude;
  final double currentLongitude;
  final bool isSelecting;

  MapDisplay({
    this.currentLatitude,
    this.currentLongitude,
    this.isSelecting,
  });

  @override
  _MapDisplayState createState() => _MapDisplayState();
}

class _MapDisplayState extends State<MapDisplay> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
            ),
        ],
      ),
      body: GoogleMap(
        key: Key('AIzaSyDQbZ72mMLvPF2ZZ00zGaiwTqu-5ZI6Jn4'),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          zoom: 15,
          target: LatLng(
            widget.currentLatitude,
            widget.currentLongitude,
          ),
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelecting)
            ? null
            : {
                Marker(
                  markerId: MarkerId('o'),
                  position: _pickedLocation ??
                      LatLng(
                        widget.currentLatitude,
                        widget.currentLongitude,
                      ),
                ),
              },
      ),
    );
  }
}
