import 'package:flutter/material.dart';
import 'package:greatPlaces/providers/placesProvider.dart';
import 'package:greatPlaces/screens/mapDisplay.dart';
import 'package:provider/provider.dart';

class PlaceDetails extends StatelessWidget {
  static const routeName = '/placeDetail';
  @override
  Widget build(BuildContext context) {
    final selectedPlace = Provider.of<PlacesProvider>(context, listen: false)
        .findById(ModalRoute.of(context).settings.arguments);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(selectedPlace.location.address, textAlign: TextAlign.center),
          SizedBox(height: 10),
          TextButton(
            child: Text('View On Map'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapDisplay(
                        initialLocation: selectedPlace.location,
                        isSelecting: false,
                      )));
            },
          )
        ],
      ),
    );
  }
}
