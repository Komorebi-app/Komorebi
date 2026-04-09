import 'package:fpdart/fpdart.dart';
import 'package:komorebi/errors/failure.dart';
import 'package:komorebi/features/auth/data/models/user_model.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserModel?>> getUser();
  Future<Either<Failure, bool>> login({
    required String username,
    required String password,
  });
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> register({
    required String username,
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  });
  
}
