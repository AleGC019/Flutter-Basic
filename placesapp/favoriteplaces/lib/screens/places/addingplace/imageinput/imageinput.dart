import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  ImageInput({
    super.key,
    required this.onSelectImage,
    required this.imagefile,
  });

  final void Function(File image) onSelectImage;

  File? imagefile;

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  void _takePicture() async {
    final imagePicker = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imagePicker == null) {
      return;
    }

    setState(() {
      widget.imagefile = File(imagePicker.path);
    });

    widget.onSelectImage(widget.imagefile!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = widget.imagefile == null
        ? TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera, color: Colors.black),
            label: Text('Take Picture', style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Colors.black,
            ),),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
          )
        : GestureDetector(
            onTap: _takePicture,
            child: Image.file(
              widget.imagefile!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );

    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      alignment: Alignment.center,
      child: content,
    );
  }
}
