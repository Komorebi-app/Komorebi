import 'dart:convert';

import 'package:komorebi/features/collection/data/models/book_model.dart';
import 'package:komorebi/features/collection/domain/entities/collection.dart';

class CollectionModel extends Collection {
  const CollectionModel({
    required super.id,
    required super.books,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'books': books,
    };
  }

  factory CollectionModel.fromMap(Map<String, dynamic> map) {
    return CollectionModel(
      id: map['id'] as int,
      books: (map['books'] as List<dynamic>).map((b) => BookModel.fromMap(b)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectionModel.fromJson(String source) =>
      CollectionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
