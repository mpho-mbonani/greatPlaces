import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
