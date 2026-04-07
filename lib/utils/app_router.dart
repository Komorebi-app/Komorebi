import 'package:go_router/go_router.dart';
import 'package:komorebi/pages/main_page.dart';

class AppRouter{

  final router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => MainPage()
        )
    ]
  );
}