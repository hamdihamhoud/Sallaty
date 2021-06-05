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
  // File _storedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image =
        await picker.getImage(source: ImageSource.gallery, maxWidth: 600);
    if (image == null) return;
    // setState(() {
    //   _storedImage = File(image.path);
    // });
    widget.setImage(File(image.path));
  }

  // Widget _loadImage() {
  //   if (_storedImage != null) {
  //     return Image.file(
  //       _storedImage,
  //       fit: BoxFit.cover,
  //       width: double.infinity,
  //     );
  //   } else if (widget.imageUrl.isNotEmpty) {
  //     return Image.network(widget.imageUrl);
  //   } else {
  //     return const Text(
  //       'No Image',
  //       textAlign: TextAlign.center,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    return
        // Row(
        //   children: <Widget>[
        //     Container(
        //       margin: const EdgeInsets.only(top: 8),
        //       width: mediaQuery.size.width * 0.40,
        //       height: mediaQuery.size.width * 0.40,
        //       decoration: BoxDecoration(
        //         border: Border.all(width: 1, color: Colors.grey),
        //       ),
        //       child: _loadImage(),
        //       alignment: Alignment.center,
        //     ),
        //     const SizedBox(
        //       width: 10,
        //     ),
        //     Expanded(
        // child:
        TextButton.icon(
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
      //     ),
      //   ),
      // ],
    );
  }
}
