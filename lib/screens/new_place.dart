import 'dart:io';

import 'package:favourite_places/models/favourite_place.dart';
import 'package:favourite_places/providers/favourite_places_provider.dart';
import 'package:favourite_places/widgets/image_input.dart';
import 'package:favourite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});

  @override
  ConsumerState<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlace> {
  final _formKey = GlobalKey<FormState>();
  var _title = '';

  File? _selectImage;

  void _saveNewPlace() {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      // Save the form state and fields
      _formKey.currentState!.save();

      // Generate a unique ID for the new place
      var uuid = const Uuid();
      String uniqueId = uuid.v4().substring(0, 4);

      if (_selectImage == null) {
        return;
      }

      ref.read(favouritePlacesProvider.notifier).toggleFavouritePlace(
            FavouritePlace(id: uniqueId, title: _title, image: _selectImage!),
          );

      // Navigate back with the new place data
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add new Place',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey, // Assign the formKey to the Form widget
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              const SizedBox(height: 10), // Add some spacing
              ImageInput(onPickImage: (image) {
                _selectImage = image;
              }),
              const SizedBox(height: 16),
              const LocationInput(),
              const SizedBox(
                height: 16,
              ), // Add some spacing
              ElevatedButton.icon(
                onPressed: _saveNewPlace,
                icon: const Icon(
                  Icons.add,
                  textDirection: TextDirection.rtl,
                ),
                label: const Text('Add Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
