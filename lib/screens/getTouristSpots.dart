import 'package:flutter/material.dart';
import 'package:great_places_app/screens/show_spots_screen.dart';
import 'package:great_places_app/services/apiService.dart';
import 'package:location/location.dart';

class TouristSpots extends StatefulWidget {
  const TouristSpots({Key? key}) : super(key: key);

  @override
  State<TouristSpots> createState() => _TouristSpotsState();
}

class _TouristSpotsState extends State<TouristSpots> {
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final apiService = ApiService();
  bool isBusy = false;
  @override
  Widget build(BuildContext context) {
    return isBusy
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                TextField(
                  controller: _stateController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter State Name'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter city Name'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isBusy = true;
                      });
                      await apiService
                          .findSpotsViaGeocoding(
                              city: _cityController.text.toString().trim(),
                              state: _stateController.text.toString().trim())
                          .then((value) => {
                                setState(() {
                                  isBusy = false;
                                }),
                                Navigator.pushNamed(
                                    context, ShowSpotsScreen.routeName,
                                    arguments: value),
                              });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Search Spots',
                              style: TextStyle(fontSize: 20),
                            ),
                            Icon(Icons.search)
                          ]),
                    )),
                const SizedBox(
                  height: 25,
                ),
                const Text('OR'),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isBusy = true;
                      });
                      var locationData = await Location().getLocation();
                      final _srclatitude = locationData.latitude as double;
                      final _srclongitude = locationData.longitude as double;
                      await apiService
                          .findSpotsViaReverseGeocoding(
                              lon: _srclongitude, lat: _srclatitude)
                          .then((value) => {
                                setState(() {
                                  isBusy = false;
                                }),
                                Navigator.pushNamed(
                                    context, ShowSpotsScreen.routeName,
                                    arguments: value),
                              });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Use Current Location',
                              style: TextStyle(fontSize: 20),
                            ),
                            Icon(Icons.location_on)
                          ]),
                    )),
              ]),
            ),
          );
  }
}
