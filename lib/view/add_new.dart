import 'dart:io';

import 'package:favorite_places/model/place_model.dart';
import 'package:favorite_places/provider/place_provider.dart';
import 'package:favorite_places/widget/image_input.dart';
import 'package:favorite_places/widget/map_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class AddNew extends ConsumerStatefulWidget {
  const AddNew({super.key});
  @override
  ConsumerState<AddNew> createState() {
    return _AddNewState();
  }
}

class _AddNewState extends ConsumerState<AddNew> {
  final _formKey = GlobalKey<FormState>();
  var _enteredPlace = '';

  File? image;
  LatLng? place;

  void _addNew() async {
    if (_formKey.currentState!.validate() && image != null && place != null) {
      _formKey.currentState!.save();

      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(image!.path);
      final copiedImage = await image!.copy('${appDir.path}/$fileName');

      ref.read(placeProvider.notifier).addPlace(
            PlaceModel(
              placeName: _enteredPlace,
              image: copiedImage,
              area: place!,
            ),
          );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(labelText: 'Place Name'),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length > 50) {
                      return 'Add something in valid format..';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredPlace = newValue!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ImageInput(
                  onSelectedImage: (imageSrc) => image = imageSrc,
                ),
                const SizedBox(
                  height: 10,
                ),
                MapInput(
                  onselect: (selectedPlace) {
                    place = selectedPlace;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: _addNew,
                  label: const Text('Add Place'),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
