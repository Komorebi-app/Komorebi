import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String firstname;
  final String lastname;
  final String username;
  final int library;

  const User({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.library,
  });

  @override
  List<Object?> get props => [
    id,
    email,
    firstname,
    lastname,
    username,
    library,
  ];

  @override
  bool get stringify => true;
}
