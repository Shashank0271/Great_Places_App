import 'dart:io';
import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import '../widgets/image_input.dart';
import 'package:provider/provider.dart';
import 'package:great_places_app/models/place.dart';
import 'package:great_places_app/services/database_helper.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add_place_screen';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    TextEditingController titleTextController = TextEditingController();
    File? _pickedImage;

    void selectImage(File pickedImage) {
      //just so we can bring the file to this dart file
      //since the code to save the place is in this file
      _pickedImage = pickedImage;
    }

    void _savePlace() async {
      if (titleTextController.text.isEmpty || _pickedImage == null) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  content: const Text('Enter the image and title'),
                  title: const Text('Please enter both the image and title!'),
                  actions: [
                    IconButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      icon: Icon(
                        Icons.check_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ));
        return;
      }
      Provider.of<GreatPlaces>(context, listen: false)
          .addPlace(titleTextController.text, _pickedImage!);
      _databaseHelper.create(Place(
          title: titleTextController.text.toString(), image: _pickedImage));
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: titleTextController,
                      decoration: const InputDecoration(
                        labelText: 'title',
                        hintText: 'Enter the title here',
                      ),
                    ),
                    const SizedBox(height: 10),
                    ImageInput(selectImage),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            label: Text(
              'Add Place',
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: _savePlace,
            icon: Icon(
              Icons.add,
              color: Theme.of(context).iconTheme.color,
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                primary: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }
}
