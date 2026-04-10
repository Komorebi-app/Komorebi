import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:komorebi/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:komorebi/features/collection/presentation/bloc/collection_bloc.dart';
import 'package:komorebi/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komorebi/features/theme/theme_cubit.dart';
import './theme/app_theme.dart';
import 'router/app_router.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<CollectionBloc>()),
      ],
      child: EasyLocalization(
        supportedLocales: [
          Locale('en'),
          Locale('fr'),
        ],
        saveLocale: true,
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: MainApp(),
      ),
    ),
  );

  FlutterNativeSplash.remove();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          themeMode: themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          title: 'Komorebi',
          routerConfig: appRouter,
        );
      },
    );
  }
}
