import 'package:fpdart/fpdart.dart';
import 'package:komorebi/failure.dart';
import 'package:komorebi/features/auth/domain/repositories/auth_repository.dart';
import 'package:komorebi/usecase.dart';

class Login implements UseCase<bool, LoginParams> {
  final AuthRepository authRepository;

  Login(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(LoginParams params) async {
    return await authRepository.login(
      username: params.username,
      password: params.password,
    );
  }
}

class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});
}
