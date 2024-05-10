
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import '../../../features/auth/presentation/pages/sign_in_page.dart';
import '../../../features/auth/presentation/widgets/sign_up.dart';
import '../../../features/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@singleton
class AppRouter {
  final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
    GoRoute(
    path: '/',
    builder: (context, state) => supabase.auth.currentSession != null ? const HomeScreen() : const SignInPage(),
  ),
]
  );

  GoRouter get router => _router;
}

var supabase = Supabase.instance.client;
