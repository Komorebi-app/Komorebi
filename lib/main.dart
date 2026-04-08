import 'package:komorebi/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:komorebi/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './features/theme/theme_cubit.dart';
import './theme/app_theme.dart';
import 'router/app_router.dart';

Future<void> main() async {
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context)=> ThemeCubit()),
      BlocProvider(create: (context)=> getIt<AuthBloc>()),
    ], 
    child: const MainApp())
    );
}
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
            themeMode: themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            title: 'Komorebi',
            routerConfig: appRouter,
          );
      }
    );
  }
}
