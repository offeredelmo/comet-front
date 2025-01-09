import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerExample extends StatefulWidget {
  final Function(File) onImageSelected; // Callback para notificar al padre

  const ImagePickerExample({
    Key? key,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        final tempImage = File(pickedFile.path);
        setState(() {
          _image = tempImage;
        });
        // Notificamos al padre
        widget.onImageSelected(tempImage);
      }
    } catch (e) {
      print("Error al seleccionar imagen: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: _pickImage,
          child: const Icon(Icons.add_photo_alternate_outlined),
        ),
        const SizedBox(width: 10),
        _image != null
            ? Image.file(
                _image!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              )
            : const Text('No hay imagen seleccionada'),
      ],
    );
  }
}
//////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////

class ImagePickerEdit extends StatefulWidget {
  final Function(File) onImageSelected; // Callback para notificar al padre
  final String? urlImage;

  const ImagePickerEdit({
    Key? key,
    required this.onImageSelected,
    this.urlImage,
  }) : super(key: key);

  @override
  _ImagePickerEditState createState() => _ImagePickerEditState();
}

class _ImagePickerEditState extends State<ImagePickerEdit> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        final tempImage = File(pickedFile.path);
        setState(() {
          _image = tempImage;
        });
        // Notificamos al padre
        widget.onImageSelected(tempImage);
      }
    } catch (e) {
      print("Error al seleccionar imagen: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: _pickImage,
          child: const Icon(Icons.add_photo_alternate_outlined),
        ),
        const SizedBox(width: 10),
        _image != null
            ? Image.file(
                _image!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              )
            : (widget.urlImage == null)
                ? Text("No hay imagen")
                : Image.network(
                    "${widget.urlImage}",
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )
      ],
    );
  }
}
