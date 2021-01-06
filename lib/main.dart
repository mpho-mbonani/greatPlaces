import 'package:flutter/material.dart';
import 'package:greatPlaces/screens/addPlace.dart';
import 'package:greatPlaces/screens/placeDetails.dart';
import 'package:provider/provider.dart';

import 'screens/placesList.dart';
import 'providers/placesProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlacesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Great Places',
        theme: ThemeData(
          backgroundColor: Colors.white,
          primaryColor: Colors.white,
          accentColor: Colors.black,
          primarySwatch: Colors.amber,
        ),
        home: PlacesList(),
        routes: {
          AddPlace.routeName: (ctx) => AddPlace(),
          PlaceDetails.routeName: (ctx) => PlaceDetails(),
        },
      ),
    );
  }
}
