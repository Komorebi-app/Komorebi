import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CustomFilePicker extends StatefulWidget {
  Function(String) sendImage;
  CustomFilePicker({super.key, required this.sendImage});

  @override
  State<CustomFilePicker> createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  String? image;
   Future<void> chooseFile() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'svg'],
    );
    if (result != null) {
        image = result.files.first.path;
      setState(() {});
    } else {
      // User canceled the picker
    }
  }
    
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        chooseFile();
      },
      child: Container(
        decoration: BoxDecoration(
          border: image == null ? Border.all() : Border(),
          borderRadius: BorderRadius.circular(24)
        ),
        width: 150,
        height: 200,
        child: image == null
          ? const Icon(Icons.add_a_photo, size: 48)
          : ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(24),
            child: Image.file(File(image!,
            )
                    ),
          ),
      )
      );
  }
}


  

