import 'package:equatable/equatable.dart';
import 'package:komorebi/features/collection/data/models/author_model.dart';

class Book extends Equatable {
  final int id;
  final String title;
  final String? coverUrl;
  final AuthorModel author;
  final String isbn;
  final String language;
  final int pages;
  final DateTime? published;
  final String? resume;
  final int progress;

  const Book({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.author,
    required this.isbn,
    required this.language,
    required this.pages,
    required this.published,
    required this.resume,
    required this.progress,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    coverUrl,
    author,
    isbn,
    language,
    pages,
    published,
    resume,
    progress,
  ];

  @override
  bool get stringify => true;
}
