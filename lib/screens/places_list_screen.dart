import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: Consumer<GreatPlaces>(
        child: const Center(
          child: Text('no places added'),
        ),
        builder: (ctx, gp, ch) => gp.items.length <= 0
            ? ch!
            : ListView.builder(
                itemCount: gp.items.length,
                itemBuilder: (ctx, index) => ListTile(
                        leading: CircleAvatar(
                      backgroundImage: FileImage(gp.items[index].image!),
                    ))),
      ),
    );
  }
}
