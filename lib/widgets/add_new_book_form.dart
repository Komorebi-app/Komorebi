import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:komorebi/config/app_config.dart';
import 'package:komorebi/features/auth/domain/services/auth_service.dart';
import 'package:komorebi/init_dependencies.dart';
import './file_picker.dart';

const List<String>languages =['Fr', 'En','Es','It','Al','Ru' ];
enum ApiStatus {idle, loading, success, error}


class AddNewBookForm extends StatefulWidget {
  final Function() closeModalFunction;
  const AddNewBookForm({super.key, required this.closeModalFunction});
  
  
  @override
  State<AddNewBookForm> createState() => _AddNewBookFormState();
}

class _AddNewBookFormState extends State<AddNewBookForm> {
  final dio = Dio();
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final isbnNumberController = TextEditingController();
  String dropDownValue = languages.first;
  PlatformFile? imageCover;
  String message = '';
  ApiStatus status = ApiStatus.idle;

  void handleImage(PlatformFile data) {
    setState(() {
      imageCover = data;
    });
  }



  Future<void> addNewBook() async {
    setState(() => status = ApiStatus.loading);
    if (imageCover == null || imageCover!.path == null) {
      setState(() {
        message = "Veuillez sélectionner une image";
      });
      return; 
    }

    try {
      FormData formData = FormData.fromMap({
        'isbn': isbnNumberController.text.trim(),
        'title': titleController.text.trim(),
        'author': authorController.text.trim(),
        'language': dropDownValue,
        'image': await MultipartFile.fromFile(
          imageCover!.path!, 
          filename: imageCover!.name,
        ),
      });
    
        final response = await dio.post(
          '${AppConfig.apiUrl}/book/add-manual-to-library/',
          data:formData, options: Options(
            headers: {
              'Authorization': 'Bearer ${await AuthService(getIt<FlutterSecureStorage>()).getToken()}' 
            },
            contentType: 'multipart/form-data'
          )
        );
        if(response.statusCode == 201){
          message = 'Livre ajouté à la collection !';
          setState(() => status = ApiStatus.success);
          widget.closeModalFunction();
        } else {
          message = "Erreur lors de l'ajout du livre";
          setState(() => status = ApiStatus.error);
        }
      } on DioException catch (e) {
          if (e.response != null) {
          message = 'Erreur serveur';        }
    message = 'Erreur de validation';
}
  }


  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    authorController.dispose();
    isbnNumberController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 24,
          children: [
            TextFormField(
                decoration: InputDecoration(
                  labelText: 'Titre du livre',
                  hintText: 'Exemple: Coder proprement'
                ),
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Champ non valide";
                  }
                  return null;
                },
            ),
            TextFormField(
                decoration: InputDecoration(
                  labelText: 'Auteur',
                  hintText: 'Exemple: Robert C Martin'
                ),
                controller: authorController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Champ non valide";
                  }
                  return null;
                },
            ),
            TextFormField(
                decoration: InputDecoration(
                  labelText: 'Numéro ISBN',
                  hintText: 'Exemple: 978-2-3260-0227-2'
                ),
                controller: isbnNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Champ non valide";
                  }
                  return null;
                },
            ),
            InputDecorator(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: .circular(12),
                  borderSide: BorderSide(
                    color: Colors.black,
                  )
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text('Langue'),
                  items: languages.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                    }).toList(),
                  icon: Icon(Icons.keyboard_arrow_down),
                  borderRadius: BorderRadius.circular(10),
                  value: dropDownValue, 
                  elevation: 16,
                  onChanged: (String? value) {
                    setState(() {
                      dropDownValue = value!;
                    });
                  
                  },
                ),
              ),
            ),
            CustomFilePicker(sendImage: handleImage,),
            ElevatedButton(
              onPressed: (){
                addNewBook();
              }, 
              child: Text('Valider',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface
                ),
              )
            ),
            Container(
              child: status == ApiStatus.loading ? CircularProgressIndicator() : Text('')
              )
          ],
        ),
      ),
    );
  }
}