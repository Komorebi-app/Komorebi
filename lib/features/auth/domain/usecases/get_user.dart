import 'package:fpdart/fpdart.dart';
import 'package:komorebi/failure.dart';
import 'package:komorebi/features/auth/data/models/user_model.dart';
import 'package:komorebi/features/auth/domain/repositories/auth_repository.dart';
import 'package:komorebi/usecase.dart';

class GetUser implements UseCase<UserModel?, NoParams> {
  final AuthRepository authRepository;

  GetUser(this.authRepository);

  @override
  Future<Either<Failure, UserModel?>> call([NoParams? params]) async {
    return await authRepository.getUser();
  }
}
