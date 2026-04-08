import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:komorebi/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:komorebi/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:komorebi/features/auth/domain/repositories/auth_repository.dart';
import 'package:komorebi/features/auth/domain/usecases/get_user.dart';
import 'package:komorebi/features/auth/domain/usecases/login.dart';
import 'package:komorebi/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:path_provider/path_provider.dart';

GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  getIt.registerSingleton(Dio());
  getIt.registerSingleton(FlutterSecureStorage());

  initAuth();
}

void initAuth() {
  getIt
    // Datasource
    ..registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(
        dio: getIt(),
        storage: getIt()
      ),
    )
    // Repositories
    ..registerCachedFactory<AuthRepository>(() => AuthRepositoryImpl(getIt()))
    // Usecases
    ..registerFactory<Login>(() => Login(getIt()))
    ..registerFactory<GetUser>(() => GetUser(getIt()))
    // Bloc
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        login: getIt(),
        getUser: getIt(),
      )
    );
}
