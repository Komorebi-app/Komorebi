import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komorebi/features/auth/data/models/user_model.dart';
import 'package:komorebi/features/auth/domain/usecases/get_user.dart';
import 'package:komorebi/features/auth/domain/usecases/login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final GetUser getUser;

  AuthBloc({
    required this.login,
    required this.getUser,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthInitial());
    });
    on<AuthLoginEvent>(
      (event, emit) => _onLoginEvent(event, emit),
    );
    on<AuthGetUserEvent>(
      (event, emit) => _onGetUserEvent(event, emit),
    );
    add(AuthGetUserEvent());
  }

  Future<void> _onLoginEvent(
    AuthLoginEvent event,
    Emitter emit,
  ) async {
    final result = await login(
      LoginParams(username: event.username, password: event.password),
    );

    result.fold(
      (l) {
        emit(AuthFailure(message: l.message));
      },
      (r) {
        emit(AuthLoggingSuccess());
      },
    );
  }

  Future<void> _onGetUserEvent(
    AuthGetUserEvent event,
    Emitter emit,
  ) async {
    emit(AuthLoading());
    final result = await getUser();

    result.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => emit(AuthSuccess(user: r)),
    );
  }
}
