// import 'dart:async';
// import 'package:dartz/dartz.dart';
// import 'package:injectable/injectable.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:dio/dio.dart';
//
// abstract class AuthDataSource {
//
//   AuthDataSource(Dio dio);
//
//
//   Future<Unit> signUpUser(String email, String password);
//
//   Future<Unit> signInUser(String email, String password);
//
//   Future<Unit> logOut();
//
// }
// @Injectable(as: AuthDataSource)
// class AuthRemoteDataSourceImpl implements AuthDataSource {
//   AuthRemoteDataSourceImpl();
//
//   final supabase = Supabase.instance.client;
//
//   @override
//   Future<unit> signUpUser(String email, String password) async {
//     try {
//       final AuthResponse res = await supabase.auth.signUp(
//         email: email,
//         password: password,
//       );
//
//       final Session? session = res.session;
//       final User? user = res.user;
//       print(" print(signInUser $res)");
//       print("signInUser $user");
//       print("session $session");
//
//     } catch (e) {
//       print('Error fetching products: $e');
//       return [];
//     }
//
//   }
//
//   @override
//   Future<unit> signInUser(String email, String password) async {
//     final AuthResponse res = await supabase.auth.signInWithPassword(
//       email: email,
//       password: password,
//     );
//     final Session? session = res.session;
//     final User? user = res.user;
//     if (user == null) {
//       print('Error signing in');
//     } else {
//       // Token obtained successfully
//       final token = session?.accessToken;
//       // print('Token: $token');
//       // GetStorage().write('token', token);
//       // print('tokenValue: ${GetStorage().read('token')}');
//     }
//   }
//
//   @override
//   Future<unit> logOut() async {
//    await supabase.auth.signOut() ;
//   }
// }
