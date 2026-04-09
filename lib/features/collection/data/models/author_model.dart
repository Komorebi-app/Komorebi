import 'dart:convert';

import 'package:komorebi/features/collection/domain/entities/author.dart';

class AuthorModel extends Author {
  const AuthorModel({
    required super.id,
    required super.firstname,
    required super.lastname,
    required super.biography,
  });

  String getFullname() {
    return "$firstname $lastname";
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': firstname,
      'last_name': lastname,
      'biography': biography,
    };
  }

  factory AuthorModel.fromMap(Map<String, dynamic> map) {
    return AuthorModel(
      id: map['id'] as int,
      firstname: map['first_name'] as String,
      lastname: map['last_name'] as String,
      biography: map['biography'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthorModel.fromJson(String source) =>
      AuthorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
