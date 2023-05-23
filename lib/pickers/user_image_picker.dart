import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
 
   final void Function (File pickedImage)  imagepickfn;

   UserImagePicker({ required this.imagepickfn});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource src) async {
    final pickedImageFile = await _picker.pickImage(source: src,imageQuality: 50,maxWidth: 150);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.imagepickfn(_pickedImage!);
    } else {
      print('No Image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.photo_camera_back_outlined),
              label: const Text(
                'Add Image\nfrom camera',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.image_outlined),
              label: const Text(
                'Add Image\nfrom Gallery',
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }
}
