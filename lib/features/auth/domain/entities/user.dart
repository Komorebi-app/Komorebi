import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String firstname;
  final String lastname;
  final String username;

  const User({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.username,
  });

  @override
  List<Object?> get props => [id, email, firstname, lastname, username];

  @override
  bool get stringify => true;
}
