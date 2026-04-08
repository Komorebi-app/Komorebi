import 'package:fpdart/fpdart.dart';
import 'package:komorebi/errors/failure.dart';
import 'package:komorebi/features/auth/domain/repositories/auth_repository.dart';
import 'package:komorebi/usecase.dart';

class Logout implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  Logout(this.authRepository);

  @override
  Future<Either<Failure, void>> call([NoParams? params]) async {
    return await authRepository.logout();
  }
}
