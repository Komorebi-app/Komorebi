import 'package:go_router/go_router.dart';
import 'package:komorebi/features/auth/presentation/pages/auth_page.dart';
import 'package:komorebi/features/auth/presentation/pages/login_page.dart';
import 'package:komorebi/pages/main_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/auth',
  routes: <GoRoute>[
    GoRoute(path: '/', builder: (builder, state) => MainPage()),
    GoRoute(path: '/auth', builder: (builder, state) => AuthPage()),
    GoRoute(path: '/auth/login', builder: (builder, state) => LoginPage()),
  ],
);
