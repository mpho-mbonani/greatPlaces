import 'package:flutter/material.dart';
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
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.black87,
          accentColor: Colors.amber,
        ),
        home: PlacesList(),
      ),
    );
  }
}
