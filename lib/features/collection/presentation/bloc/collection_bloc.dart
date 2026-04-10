import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komorebi/features/collection/data/models/collection_model.dart';
import 'package:komorebi/features/collection/domain/usecases/get_collection.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final GetCollection getCollection;

  CollectionBloc({
    required this.getCollection
  }) : super(CollectionInitial()) {
    on<CollectionEvent>((event, emit) {
      emit(CollectionInitial());
    });
    on<CollectionGetEvent>((event, emit) => _onGetCollection(event, emit));
  }

  Future<void> _onGetCollection(CollectionGetEvent event, Emitter emit) async {
    final result = await getCollection(
      GetCollectionParams(
        id: event.id,
      ),
    );

    result.fold(
      (l) {
        emit(CollectionFailure(message: l.message));
      },
      (r) {
        emit(CollectionSuccess(collection: r));
      },
    );
  }
}
