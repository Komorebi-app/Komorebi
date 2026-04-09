import 'package:fpdart/fpdart.dart';
import 'package:komorebi/errors/failure.dart';
import 'package:komorebi/features/auth/domain/repositories/auth_repository.dart';
import 'package:komorebi/usecase.dart';

class Register implements UseCase<bool, RegisterParams> {
  final AuthRepository authRepository;

  Register(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(RegisterParams params) async {
    return await authRepository.register(
      username: params.username,
      firstname: params.firstname,
      lastname: params.lastname,
      email: params.email,
      password: params.password,
    );
  }
}

class RegisterParams {
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  RegisterParams({
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });
}
