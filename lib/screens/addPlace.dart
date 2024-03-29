import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greatPlaces/models/coordinates.dart';
import 'package:greatPlaces/providers/placesProvider.dart';
import 'package:greatPlaces/widgets/imageInput.dart';
import 'package:greatPlaces/widgets/locationInput.dart';
import 'package:provider/provider.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/addPlace';
  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _titleController = TextEditingController();
  File _pickedImage;
  Coordinates _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double latitude, double longitude) {
    _pickedLocation = Coordinates(latitude: latitude, longitude: longitude);
  }

  void _savePlace() {
    if (_titleController.text.isNotEmpty &&
        _pickedImage != null &&
        _pickedLocation != null) {
      Provider.of<PlacesProvider>(context, listen: false)
          .addPlace(_titleController.text, _pickedImage, _pickedLocation);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      //ideally should be form
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(_selectImage),
                    SizedBox(height: 10),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text('Place'),
          )
        ],
      ),
    );
  }
}
