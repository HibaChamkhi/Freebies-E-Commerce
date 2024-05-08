import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants/app_constants.dart';

@module
abstract class RegisterModule {
  // Inject SharedPreferences
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  // Inject Dio
  @lazySingleton
  Dio dio(SharedPreferences sharedPreferences) {
    final token = sharedPreferences.getString('token') ?? '';

    return Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        headers: {
          if (token.isNotEmpty) HttpHeaders.authorizationHeader: "Bearer $token",
        },
      ),
    )..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        maxWidth: 120,
      ),
    );
  }
}
