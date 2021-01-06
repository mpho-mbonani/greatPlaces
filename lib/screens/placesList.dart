import 'package:flutter/material.dart';
import 'package:greatPlaces/providers/placesProvider.dart';
import 'package:greatPlaces/screens/placeDetails.dart';
import 'package:provider/provider.dart';

import 'addPlace.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlace.routeName);
              })
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, previousState) => previousState.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<PlacesProvider>(
                child: Center(
                  child: const Text('No Places Yet'),
                ),
                builder: (ctx, greatPlaces, child) =>
                    greatPlaces.items.length <= 0
                        ? child
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlaces.items[i].image)),
                              title: Text(greatPlaces.items[i].title),
                              subtitle:
                                  Text(greatPlaces.items[i].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    PlaceDetails.routeName,
                                    arguments: greatPlaces.items[i].id);
                              },
                            ),
                          ),
              ),
      ),
    );
  }
}
