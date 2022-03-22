import 'package:flutter/material.dart';

import '../widgets/image_input.dart';

class AddPlaceScreen extends StatelessWidget {
  static const routeName = '/add_place_screen';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleTextController = TextEditingController();
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
                    const ImageInput(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              color: Theme.of(context).iconTheme.color,
            ),
            label: Text(
              'Add Place',
              style: Theme.of(context).textTheme.button,
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
