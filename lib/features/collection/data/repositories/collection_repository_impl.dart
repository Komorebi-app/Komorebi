import 'package:fpdart/fpdart.dart';
import 'package:komorebi/errors/exceptions.dart';
import 'package:komorebi/errors/failure.dart';
import 'package:komorebi/features/collection/data/datasources/collection_remote_datasource.dart';
import 'package:komorebi/features/collection/data/models/collection_model.dart';
import 'package:komorebi/features/collection/domain/repositories/collection_repository.dart';

class CollectionRepositoryImpl implements CollectionRepository {
  final CollectionRemoteDatasource collectionRemoteDatasource;

  CollectionRepositoryImpl(this.collectionRemoteDatasource);

  @override
  Future<Either<Failure, CollectionModel>> getCollection({
    required int id,
  }) async {
    try {
      return right(await collectionRemoteDatasource.getCollection(id: id));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
