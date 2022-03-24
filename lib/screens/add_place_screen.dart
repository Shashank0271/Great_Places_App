import 'dart:io';
import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import '../widgets/image_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add_place_screen';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleTextController = TextEditingController();
    File? _pickedImage;

    void selectImage(File pickedImage) {
      _pickedImage = pickedImage;
    }

    void _savePlace() {
      if (titleTextController.text.isEmpty || _pickedImage == null) {
        return;
      }
      Provider.of<GreatPlaces>(context, listen: false)
          .addPlace(titleTextController.text, _pickedImage!);
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
