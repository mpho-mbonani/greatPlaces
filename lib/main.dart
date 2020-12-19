import 'package:flutter/material.dart';
import 'package:greatPlaces/screens/addPlace.dart';
import 'package:provider/provider.dart';

import 'screens/placesList.dart';
import 'providers/greatPlaces.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
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
          AddPlace.routename: (ctx) => AddPlace(),
        },
      ),
    );
  }
}
