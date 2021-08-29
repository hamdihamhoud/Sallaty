import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function setImage;

  ImageInput(this.setImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image =
        await picker.getImage(source: ImageSource.gallery, maxWidth: 600);
    if (image == null) return;
    widget.setImage(File(image.path));
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(
        Icons.image,
        color: Theme.of(context).primaryColor,
      ),
      label: const Padding(
        padding: const EdgeInsets.only(top: 18.0, bottom: 18.0, left: 8),
        child: const Text(
          'Upload Image',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      onPressed: _pickImage,
    );
  }
}
