import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './file_picker.dart';

const List<String>languages =['Français', 'Anglais','Espagnol','Italien','Allemand','Russe', 'Autre' ];

class AddNewBookForm extends StatefulWidget {
  const AddNewBookForm({super.key});
  
  @override
  State<AddNewBookForm> createState() => _AddNewBookFormState();
}

class _AddNewBookFormState extends State<AddNewBookForm> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final isbnNumberController = TextEditingController();
  String dropDownValue = languages.first;
  String? imageCover;
  String message = '';
  final dio = Dio();


  void handleImage(String data) {
    setState(() {
      imageCover = data;
    });
  }

  Future<void> addNewBook() async {
    try {
      final response = await dio.post(
        '',
        data:{}
      );

    } on DioException {
      message = 'Erreur';
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
              onPressed: (){}, 
              child: Text('Valider',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}