import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
import "../class/Book.dart";


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final dio = Dio();

  void getHttp() async {
    final response = await dio.get('http://127.0.0.1:8000/api/book');
    print(response);
  }

  // Future<Book> fetchBooks() async{
  //   final response = await http.get(Uri.parse("https://www.googleapis.com/books/v1/volumes?q=naruto"));
  //   print(response.body);
    
  //   if (response.statusCode == 200) {
  //     return Book.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  //   } else {
  //     throw Exception("Failed to load book");
  //   }
  // }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(top:15),
            child: SearchBar(
              leading: Icon(Icons.search),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              hintText: "Rechercher un livre" ,
              onChanged: (value) {
                getHttp();
              },
              textStyle: WidgetStatePropertyAll(
                TextStyle(
                fontSize: 20
                )
                ),
              ),
          )
          ]
      ),

          );
  }
}
