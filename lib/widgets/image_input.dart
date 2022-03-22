import 'dart:io';
import 'package:flutter/material.dart';

class ImageInput extends StatelessWidget {
  const ImageInput({
    Key? key,
    this.storedImage,
  }) : super(key: key);
  final File? storedImage;
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
            onPressed: null,
            label: const Text('Upload image'),
          ),
        ),
      ],
    );
  }
}
