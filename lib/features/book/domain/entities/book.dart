import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final int id;
  final String title;
  final String author;
  final String isbn;
  final String language;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.isbn,
    required this.language
  });

  @override
  List<Object?> get props => [id, title, author, isbn, language];

  @override
  bool get stringify => true;




}
