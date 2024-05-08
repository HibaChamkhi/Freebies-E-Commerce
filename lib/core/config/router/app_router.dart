
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import '../../../features/home.dart';
@singleton
class AppRouter {
  final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
    GoRoute(
    path: '/',
    builder: (context, state) => HomeScreen(),
  ),
]
  );

  GoRouter get router => _router;
}

