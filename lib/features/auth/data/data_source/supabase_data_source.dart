import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:freebies_e_commerce/features/auth/data/models/user.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dio/dio.dart';

abstract class AuthDataSource {

  AuthDataSource(Dio dio);

  Future<Unit> signUpUser(UserModel user,File imageFile);

  Future<Unit> signInUser(String email, String password);

  Future<Unit> logOut();
}

@Injectable(as: AuthDataSource)
class AuthRemoteDataSourceImpl implements AuthDataSource {
  AuthRemoteDataSourceImpl();

  final supabase = Supabase.instance.client;


  Future<String> uploadImage(File imageFile, String id) async {
    final userId = id;
    try {
      final supabase = Supabase.instance.client;
      var res = await supabase.storage.from('user_image').upload('/$userId/profile', imageFile);
      print("Upload successful: $res");
      return supabase.storage.from('user_image').getPublicUrl('/$userId/profile');
    } catch (e) {
      print("Error uploading image: $e");
      return '';
    }
  }


  @override
  Future<Unit> signUpUser(UserModel user, File imageFile) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(email: user.email, password: user.password, data: {"username": user.username, "image": ""});
      final String imageUrl = await uploadImage(imageFile!, res.user?.id ?? "");
      final userUpdated = await supabase.auth.updateUser(
        UserAttributes(
          data:  {"image": imageUrl}
        ),
      );
      print("User updated: $userUpdated");
      return Future.value(unit);
    } catch (e) {
      print('Error during sign up: $e');
      return Future.value(unit);
    }
  }



  @override
  Future<Unit> signInUser(String email, String password) async {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final Session? session = res.session;
    final User? user = res.user;
    if (user == null) {
      print('Error signing in');
      return Future.value(unit);
    } else {
      return Future.value(unit);
    }
  }

  @override
  Future<Unit> logOut() async {
    await supabase.auth.signOut();
    return Future.value(unit); // Successful logout.
  }
}
