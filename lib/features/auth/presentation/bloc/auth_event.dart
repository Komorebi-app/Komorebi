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
