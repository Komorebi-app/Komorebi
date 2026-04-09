import 'package:flutter/material.dart';
import '../widgets/add_new_book_modal.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search))),
        AddNewBookModal()
      ],
    );
  }
}
