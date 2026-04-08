part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;

  const AuthLoginEvent({required this.username, required this.password});
}

class AuthGetUserEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}

class AuthRegisterEvent extends AuthEvent {
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  const AuthRegisterEvent({
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });
}
