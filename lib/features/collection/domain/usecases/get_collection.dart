import 'package:fpdart/fpdart.dart';
import 'package:komorebi/errors/failure.dart';
import 'package:komorebi/features/collection/data/models/collection_model.dart';
import 'package:komorebi/features/collection/domain/repositories/collection_repository.dart';
import 'package:komorebi/usecase.dart';

class GetCollection implements UseCase<CollectionModel, GetCollectionParams> {
  final CollectionRepository collectionRepository;

  GetCollection(this.collectionRepository);

  @override
  Future<Either<Failure, CollectionModel>> call(GetCollectionParams params) async {
    return await collectionRepository.getCollection(id: params.id);
  }
}

class GetCollectionParams {
  final int id;

  GetCollectionParams({required this.id});
}
