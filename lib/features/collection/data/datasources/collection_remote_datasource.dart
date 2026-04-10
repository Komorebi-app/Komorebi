import 'package:dio/dio.dart';
import 'package:komorebi/config/app_config.dart';
import 'package:komorebi/errors/exceptions.dart';
import 'package:komorebi/features/auth/domain/services/auth_service.dart';
import 'package:komorebi/features/collection/data/models/collection_model.dart';

abstract interface class CollectionRemoteDatasource {
  Future<CollectionModel> getCollection({required int id});
}

class CollectionRemoteDatasourceImpl implements CollectionRemoteDatasource {
  final Dio dio;
  final AuthService service;
  final String apiUrl = AppConfig.apiUrl;

  CollectionRemoteDatasourceImpl({required this.dio, required this.service});

  @override
  Future<CollectionModel> getCollection({
    required int id,
  }) async {
    try {
      String? token = await service.getToken();
      final response = await dio.get(
        '$apiUrl/library/$id/',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) => [200].contains(status!),
        ),
      );

      return CollectionModel.fromMap(response.data);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
