import 'package:fpdart/fpdart.dart';
import 'package:komorebi/errors/exceptions.dart';
import 'package:komorebi/errors/failure.dart';
import 'package:komorebi/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:komorebi/features/auth/data/models/user_model.dart';
import 'package:komorebi/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl(this.authRemoteDatasource);
  
  @override
  Future<Either<Failure, UserModel?>> getUser() async {
    try {
      return right(await authRemoteDatasource.getUser());
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> login({
    required String username,
    required String password,
  }) async {
    try {
      return Right(
        await authRemoteDatasource.login(
          username: username,
          password: password,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return right(await authRemoteDatasource.logout());
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> register({
    required String username,
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    try {
      return Right(
        await authRemoteDatasource.register(
          username: username,
          firstname: firstname,
          lastname: lastname,
          email: email,
          password: password,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
