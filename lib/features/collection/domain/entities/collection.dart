import 'package:equatable/equatable.dart';
import 'package:komorebi/features/collection/data/models/book_model.dart';

class Collection extends Equatable {
  final int id;
  final List<BookModel> books;

  const Collection({
    required this.id,
    required this.books,
  });

  @override
  List<Object?> get props => [
    id,
    books,
  ];

  @override
  bool get stringify => true;
}
