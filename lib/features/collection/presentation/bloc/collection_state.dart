part of 'collection_bloc.dart';

abstract class CollectionState extends Equatable {
  const CollectionState();  

  @override
  List<Object> get props => [];
}

class CollectionInitial extends CollectionState {}

final class CollectionSuccess extends CollectionState {
  final CollectionModel collection;

  const CollectionSuccess({required this.collection});
}

final class CollectionFailure extends CollectionState {
  final String message;

  const CollectionFailure({required this.message});
}

final class CollectionLoading extends CollectionState {}
