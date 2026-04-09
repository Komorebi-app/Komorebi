import 'package:equatable/equatable.dart';

class Author extends Equatable {
  final int id;
  final String firstname;
  final String lastname;
  final String? biography;

  const Author({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.biography,
  });

  @override
  List<Object?> get props => [
    id,
    firstname,
    lastname,
    biography,
  ];

  @override
  bool get stringify => true;
}
