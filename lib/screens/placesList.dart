import 'package:flutter/material.dart';
import 'package:greatPlaces/providers/greatPlaces.dart';
import 'package:provider/provider.dart';

import 'addPlace.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 253, 208, 1), //cream
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlace.routename);
              })
        ],
      ),
      body: Consumer<GreatPlaces>(
        child: Center(
          child: const Text('No Places Yet'),
        ),
        builder: (ctx, greatPlaces, child) => greatPlaces.items.length <= 0
            ? child
            : ListView.builder(
                itemCount: greatPlaces.items.length,
                itemBuilder: (ctx, i) => ListTile(
                  leading: CircleAvatar(
                      backgroundImage: FileImage(greatPlaces.items[i].image)),
                  title: Text(greatPlaces.items[i].title),
                  onTap: () {
                    // go to detail page
                  },
                ),
              ),
      ),
    );
  }
}
