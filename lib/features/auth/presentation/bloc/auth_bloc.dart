import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komorebi/features/auth/data/models/user_model.dart';
import 'package:komorebi/features/auth/domain/usecases/get_user.dart';
import 'package:komorebi/features/auth/domain/usecases/login.dart';
import 'package:komorebi/features/auth/domain/usecases/logout.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetUser getUser;
  final Login login;
  final Logout logout;

  AuthBloc({required this.getUser, required this.login, required this.logout})
    : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthInitial());
    });
    on<AuthLoginEvent>((event, emit) => _onLoginEvent(event, emit));
    on<AuthGetUserEvent>((event, emit) => _onGetUserEvent(event, emit));
    on<AuthLogoutEvent>((event, emit) => _onLogoutEvent(event, emit));
  }

  Future<void> _onGetUserEvent(AuthGetUserEvent event, Emitter emit) async {
    emit(AuthLoading());
    final result = await getUser();

    result.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => emit(AuthSuccess(user: r)),
    );
  }

  Future<void> _onLoginEvent(AuthLoginEvent event, Emitter emit) async {
    final result = await login(
      LoginParams(username: event.username, password: event.password),
    );

    result.fold(
      (l) {
        emit(AuthFailure(message: l.message));
      },
      (r) {
        emit(AuthLoggingSuccess(isLogged: r));
      },
    );
  }

  Future<void> _onLogoutEvent(AuthLogoutEvent event, Emitter emit) async {
    emit(AuthLoading());
    final result = await logout();

    result.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => emit(AuthLoggoutSuccess()),
    );
  }
}
