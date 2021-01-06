import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  final imagePicker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await imagePicker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedFile != null) {
      setState(() {
        if (pickedFile != null) {
          _storedImage = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });

      final appDir = await syspath.getApplicationDocumentsDirectory();
      final filename = path.basename(_storedImage.path);
      final savedImage = await _storedImage.copy('${appDir.path}/$filename');
      widget.onSelectImage(savedImage);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.contain,
                  width: double.infinity,
                )
              : Text(
                  'No image taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera_alt),
            label: Text('Take Picture'),
            onPressed: _getImage,
          ),
        ),
      ],
    );
  }
}
