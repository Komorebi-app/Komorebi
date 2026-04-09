import 'dart:convert';

import 'package:komorebi/features/collection/data/models/author_model.dart';
import 'package:komorebi/features/collection/domain/entities/book.dart';

class BookModel extends Book {
  const BookModel({
    required super.id,
    required super.author,
    required super.coverUrl,
    required super.isbn,
    required super.language,
    required super.pages,
    required super.published,
    required super.resume,
    required super.title,
    required super.progress,
  });

  String formatedDate() {
    if (published == null) return '';
    return '${published!.day}/${published!.month}/${published!.year}';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author': author,
      'cover_url': coverUrl,
      'isbn': isbn,
      'language': language,
      'pages': pages,
      'published': published,
      'resume': resume,
      'title': title,
      'progress': progress,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    map.forEach((key, value) => print('$key: ${value.runtimeType}'));
    print(map['author']);
    return BookModel(
      id: map['id'] as int,
      author: AuthorModel.fromMap(map['author']),
      coverUrl: map['cover_url'] as String?,
      isbn: map['isbn'] as String,
      language: map['language'] as String,
      pages: map['pages'] as int,
      published: map['published'] != null
          ? DateTime.parse(map['published'] as String)
          : null,
      resume: map['resume'] as String?,
      title: map['title'] as String,
      progress: map['progress'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
