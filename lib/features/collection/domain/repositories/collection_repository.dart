import 'package:fpdart/fpdart.dart';
import 'package:komorebi/errors/failure.dart';
import 'package:komorebi/features/collection/data/models/collection_model.dart';

abstract interface class CollectionRepository {
  Future<Either<Failure, CollectionModel>> getCollection({required int id});
}
