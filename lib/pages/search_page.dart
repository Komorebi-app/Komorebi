import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  @override
  Widget build(BuildContext context) {
  final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: colors.primaryContainer,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search)
                  ),
                )
              ]
            ),
          )
        ),
      ),
    );
  }
}
