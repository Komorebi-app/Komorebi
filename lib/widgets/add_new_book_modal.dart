import 'package:flutter/material.dart';
import './add_new_book_form.dart';

class AddNewBookModal extends StatefulWidget {
  const AddNewBookModal({super.key});

  @override
  State<AddNewBookModal> createState() => _AddNewBookState();
}

class _AddNewBookState extends State<AddNewBookModal> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: const Text('Ajouter un livre manuellement'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentGeometry.centerEnd,
                                child: IconButton(
                                  icon: Image.asset('assets/closeButton.png', width: 30,),
                                  iconSize: 40,
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            )
                          ],
                        ),
                          AddNewBookForm()
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
  }
}