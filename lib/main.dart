import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/config/injection/injection.dart';
import 'core/config/router/app_router.dart';
import 'core/config/themes/app_theme.dart';
import 'core/utils/constants/app_constants.dart';

void main() async {
  await Supabase.initialize(
    url: AppConstants.baseUrl,
    anonKey: AppConstants.anonKey
  );
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(ScreenUtilInit(
    designSize: const Size(428, 936),
    builder: (BuildContext context, Widget? child) {
      return const MyApp();
    },
  ));
}

final _router = getIt<AppRouter>().router;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appTitle,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: _router,
    );
  }
}
