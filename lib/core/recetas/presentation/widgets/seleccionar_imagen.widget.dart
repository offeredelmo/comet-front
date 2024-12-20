import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerExample extends StatefulWidget {
  late File image;
  ImagePickerExample({super.key, required this.image});

  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File? _image; // Variable para almacenar la imagen seleccionada
  final ImagePicker _picker = ImagePicker(); // Instancia de ImagePicker

  // Método para seleccionar una imagen desde la galería
  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery, // Fuente: Galería
        maxHeight: 800, // Opcional: redimensionar la imagen
        maxWidth: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path); // Convierte XFile a File
          widget.image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error al seleccionar imagen: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Row(
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: const Icon(Icons.add_photo_alternate_outlined),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          child: Row(
            children: [
              _image != null
                  ? Image.file(
                      _image!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : const Text(
                      'No hay imagen seleccionada',
                      style: TextStyle(fontSize: 14),
                    ),
            ],
          ),
        )
      ],
    );
  }
}
