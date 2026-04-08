import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:komorebi/app_config.dart';
import 'package:komorebi/exceptions.dart';
import 'package:komorebi/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDatasource {
  Future<bool> login({required String username, required String password});
  Future<UserModel?> getUser();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;
  final FlutterSecureStorage storage;
  final String apiUrl = AppConfig.apiUrl;

  AuthRemoteDatasourceImpl({required this.dio, required this.storage});

  @override
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '${AppConfig.apiUrl}/token/',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        await storage.write(key: 'jwt_token', value: response.data['access']);
        return true;
      }
    } on DioException catch (e) {
      print(e);
    }
    return false;
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      String? token = await storage.read(key: 'jwt_token');
      final response = await dio.post(
        '$apiUrl/user/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        await storage.write(key: 'jwt_token', value: response.data['access']);
      }
      return null;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
