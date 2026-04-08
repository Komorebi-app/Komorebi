part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();  

  @override
  List<Object> get props => [];
}
class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserModel? user;

  const AuthSuccess({required this.user});
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
}

final class AuthLoading extends AuthState {}

final class AuthLoggingSuccess extends AuthState {
  final bool isLogged;

  const AuthLoggingSuccess({required this.isLogged});
}

final class AuthLoggoutSuccess extends AuthState {}
