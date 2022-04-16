import 'dart:io';
import 'read_only_map_screen.dart';
import 'package:flutter/material.dart';

class PlaceDetailsSCreen extends StatelessWidget {
  static const routeName = '/place_details_screen';

  const PlaceDetailsSCreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snapData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text(snapData['title'])),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Image.file(
                File(snapData['image']),
              ),
            ),
            const SizedBox(height: 100),
            Text(snapData['address']),
            const SizedBox(height: 100),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ReadOnlyMapScreen(
                          double.parse(snapData['latitude']),
                          double.parse(snapData['longitude'])),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
