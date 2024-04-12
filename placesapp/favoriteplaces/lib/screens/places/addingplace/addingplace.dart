import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/place.dart';
import '../../../provider/user_places.dart';
import 'imageinput/imageinput.dart';
import 'location/location.dart';

class AddingPlace extends ConsumerStatefulWidget {
  const AddingPlace({super.key});

  @override
  _AddingPlaceState createState() => _AddingPlaceState();
}

class _AddingPlaceState extends ConsumerState<AddingPlace> {
  final _formKey = GlobalKey<FormState>();

  File? _pickedImage;

  PlaceLocation? _pickedLocation;

  var _isSending = false;

  var _enteredName = '';

  void _resetForm() {
    _formKey.currentState!.reset();

    setState(() {
      _pickedImage = null;
      _pickedLocation = null;
    });
  }

  void _saveItem() {
    if (_formKey.currentState!.validate() &&
        _pickedImage != null &&
        _pickedLocation != null) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item added successfully'),
        ),
      );

      setState(() {
        _isSending = true;
      });

      ref.read(userPlacesProvider.notifier).addPlace(
            Place(
              name: _enteredName,
              image: _pickedImage!,
              location: _pickedLocation!,
            ),
          );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a new place',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Colors.black,
            ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Please enter a name, between 1 and 50 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                ),
                const SizedBox(height: 25),
                ImageInput(
                  onSelectImage: (image) {
                    _pickedImage = image;
                  },
                  imagefile: _pickedImage,
                ),
                const SizedBox(height: 25),
                LocationInpute(
                    onSelectLocation: (location) {
                      _pickedLocation = location;
                    },
                    locationData: _pickedLocation),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isSending
                            ? null
                            : () {
                                _resetForm();
                              },
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Colors.black, width: 1)),
                        ),
                        child: Text(
                          'Reset',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Colors.black, width: 1)),
                        ),
                        onPressed: _isSending
                            ? null
                            : () {
                                _saveItem();
                              },
                        child: _isSending
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator())
                            : Text(
                                'Save',
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
