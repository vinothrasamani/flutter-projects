import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key, required this.onselectImage});

  final void Function(File image) onselectImage;

  @override
  State<ProfileImage> createState() {
    return _ProfileImageState();
  }
}

class _ProfileImageState extends State<ProfileImage> {
  File? _pickedImageData;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 60,
      maxWidth: 150,
    );
    if (pickedImage == null) return;
    setState(() {
      _pickedImageData = File(pickedImage.path);
    });
    widget.onselectImage(_pickedImageData!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: const AssetImage('assets/images/user.png'),
            foregroundImage:
                _pickedImageData != null ? FileImage(_pickedImageData!) : null,
          ),
        ),
      ],
    );
  }
}
