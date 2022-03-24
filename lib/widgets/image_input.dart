import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path; //constructing paths
import 'package:path_provider/path_provider.dart' as syspath; //finding paths

class ImageInput extends StatefulWidget {
  final Function onSelectImage; //pointer to the function is passed
  ImageInput(this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? storedImage;
  Future<void> _takePicture() async {
    //pick image for static else use getImage()
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      storedImage = File(imageFile!.path);
    });
    final direc = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile!.path);
    final pickedImage =
        await File(imageFile.path).copy('${direc.path}/$fileName');

    widget.onSelectImage(pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 100,
          width: 150,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: storedImage != null
              ? Image.file(
                  storedImage!,
                  fit: BoxFit.cover,
                )
              : const Center(child: Text('No image available')),
        ),
        Expanded(
          child: TextButton.icon(
            icon: Icon(
              Icons.camera,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: _takePicture,
            label: const Text('Upload image'),
          ),
        ),
      ],
    );
  }
}