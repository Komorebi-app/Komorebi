import 'package:fpdart/fpdart.dart';
import 'package:komorebi/failure.dart';
import 'package:komorebi/features/auth/data/models/user_model.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserModel?>> getUser();
  Future<Either<Failure, bool>> login({
    required String username,
    required String password,
  });
  Future<Either<Failure, void>> logout();
}
