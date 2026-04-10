import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:komorebi/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:komorebi/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:komorebi/features/auth/domain/repositories/auth_repository.dart';
import 'package:komorebi/features/auth/domain/services/auth_service.dart';
import 'package:komorebi/features/auth/domain/usecases/get_user.dart';
import 'package:komorebi/features/auth/domain/usecases/login.dart';
import 'package:komorebi/features/auth/domain/usecases/logout.dart';
import 'package:komorebi/features/auth/domain/usecases/register.dart';
import 'package:komorebi/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:komorebi/features/collection/data/datasources/collection_remote_datasource.dart';
import 'package:komorebi/features/collection/data/repositories/collection_repository_impl.dart';
import 'package:komorebi/features/collection/domain/repositories/collection_repository.dart';
import 'package:komorebi/features/collection/domain/usecases/get_collection.dart';
import 'package:komorebi/features/collection/presentation/bloc/collection_bloc.dart';
import 'package:komorebi/features/theme/theme_cubit.dart';
import 'package:path_provider/path_provider.dart';

GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  await EasyLocalization.ensureInitialized();

  await dotenv.load(fileName: '.env');

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );

  getIt.registerSingleton(Dio());
  getIt.registerSingleton(
    FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  );

  getIt.registerLazySingleton(() => ThemeCubit());

  initAuth();
  initCollection();
}

void initAuth() {
  getIt
    // Services
    ..registerFactory<AuthService>(
      () => AuthService(getIt())
    )
    // Datasource
    ..registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(dio: getIt(), service: getIt()),
    )
    // Repositories
    ..registerCachedFactory<AuthRepository>(() => AuthRepositoryImpl(getIt()))
    // Usecases
    ..registerFactory<GetUser>(() => GetUser(getIt()))
    ..registerFactory<Login>(() => Login(getIt()))
    ..registerFactory<Logout>(() => Logout(getIt()))
    ..registerFactory<Register>(() => Register(getIt()))
    // Bloc
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        getUser: getIt(),
        login: getIt(),
        logout: getIt(),
        register: getIt(),
      ),
    );
}

void initCollection() {
  getIt
    // Datasource
    ..registerFactory<CollectionRemoteDatasource>(
      () => CollectionRemoteDatasourceImpl(dio: getIt(), service: getIt()),
    )
    // Repositories
    ..registerCachedFactory<CollectionRepository>(() => CollectionRepositoryImpl(getIt()))
    // Usecases
    ..registerFactory<GetCollection>(() => GetCollection(getIt()))
    // Bloc
    ..registerLazySingleton<CollectionBloc>(
      () => CollectionBloc(
        getCollection: getIt(),
      ),
    );
}
