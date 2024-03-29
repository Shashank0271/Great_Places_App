import 'dart:io';
import 'package:flutter/material.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:great_places_app/services/database_helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'place_detail_screen.dart';

class PlacesListScreen extends StatefulWidget {
  static const routeName = '/places_lists_screen';
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  State<PlacesListScreen> createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_a_photo_rounded),
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rotate,
                duration: const Duration(seconds: 1),
                alignment: Alignment.bottomCenter,
                child: const AddPlaceScreen(),
              )).then((value) {
            setState(() {});
          });
        },
      ),
      body: FutureBuilder(
          future: DatabaseHelper.instance.queryAllRows(),
          builder: (ctx, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'no places added',
                ),
              );
            }
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : AnimationLimiter(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (cx, index) =>
                          AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              child: Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: FileImage(
                                        File(snapshot.data![index]['image'])),
                                  ),
                                  trailing: IconButton(
                                      icon: Icon(
                                        Icons.delete_forever,
                                        color:
                                            Theme.of(context).colorScheme.error,
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        DatabaseHelper.instance.delete(
                                            snapshot.data![index]['id']);
                                        setState(() {});
                                      }),
                                  title: Text(snapshot.data![index]['title']),
                                  subtitle:
                                      Text(snapshot.data![index]['address']),
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  PlaceDetailsSCreen.routeName,
                                  arguments: snapshot.data![index],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
