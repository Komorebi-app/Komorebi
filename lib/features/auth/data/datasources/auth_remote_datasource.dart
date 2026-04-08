import 'package:dio/dio.dart';
import 'package:komorebi/app_config.dart';
import 'package:komorebi/exceptions.dart';
import 'package:komorebi/features/auth/data/models/user_model.dart';
import 'package:komorebi/features/auth/domain/services/auth_service.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel?> getUser();
  Future<bool> login({required String username, required String password});
  Future<void> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;
  final AuthService service;
  final String apiUrl = AppConfig.apiUrl;

  AuthRemoteDatasourceImpl({required this.dio, required this.service});

  @override
  Future<UserModel?> getUser() async {
    try {
      String? token = await service.getToken();
      final response = await dio.get(
        '$apiUrl/user/me/',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) => [200, 401].contains(status!),
        ),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        return UserModel.fromMap(response.data);
      }
      return null;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

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
        await service.saveToken(response.data['access']);
        return true;
      }
    } on DioException catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return false;
  }

  @override
  Future<void> logout() async {
    try {
      await service.logout();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
