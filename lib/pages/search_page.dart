import 'package:flutter/material.dart';
import '../widgets/add_new_book_modal.dart';
import 'package:komorebi/widgets/layout.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        crossAxisAlignment: .center,
        children: [
          TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search))),
          AddNewBookModal()
        ],
      ),
    );
  }
}
