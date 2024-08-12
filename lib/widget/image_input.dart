import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onSelectedImage});

  final void Function(File image) onSelectedImage;

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _addPic() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adding image options!'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          IconButton.filledTonal(
            onPressed: () {
              _tackPic();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.add_a_photo,
              size: 35,
            ),
          ),
          IconButton.filledTonal(
            onPressed: () {
              _selectPic();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.add_photo_alternate,
              size: 35,
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }

  void _tackPic() async {
    final imagePicker = ImagePicker();
    final imageSource = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageSource == null) return;
    setState(() {
      _selectedImage = File(imageSource.path);
    });
    widget.onSelectedImage(_selectedImage!);
  }

  void _selectPic() async {
    final imagePicker = ImagePicker();
    final imageSource = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (imageSource == null) return;
    setState(() {
      _selectedImage = File(imageSource.path);
    });
    widget.onSelectedImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = IconButton.filledTonal(
      icon: const Icon(
        Icons.image,
        size: 30,
      ),
      onPressed: _addPic,
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _addPic,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 22, 23, 22),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).appBarTheme.backgroundColor!,
        ),
      ),
      height: 250,
      width: double.infinity,
      child: content,
    );
  }
}
