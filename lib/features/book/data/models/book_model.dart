import 'dart:convert';

import 'package:komorebi/features/book/domain/entities/book.dart';

class BookModel extends Book {
  const BookModel ({
    required super.id,
    required super.title,
    required super.author,
    required super.isbn,
    required super.language
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'isbn': isbn,
      'language': language,
    };
  }
  
  factory BookModel.fromMap(Map<String, dynamic> map) {
      return BookModel(
        id: map['id'] as int,
        title: map['title'] as String,
        author: map['author'] as String,
        isbn: map['isbn'] as String,
        language: map['language'] as String,
      );
    }

    String toJson() => json.encode(toMap());

    factory BookModel.fromJson(String source) =>
        BookModel.fromMap(json.decode(source) as Map<String, dynamic>);

}