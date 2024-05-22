import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:freebies_e_commerce/features/auth/data/models/user.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/utils/error/exception.dart';

abstract class AuthDataSource {
  Future<Unit> signUpUser(UserModel user, File imageFile);

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
      var res = await supabase.storage
          .from('user_image')
          .upload('/$userId/profile', imageFile);
      return supabase.storage
          .from('user_image')
          .getPublicUrl('/$userId/profile');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Unit> signUpUser(UserModel user, File imageFile) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
          email: user.email,
          password: user.password,
          data: {"username": user.username, "image": ""});
      final String imageUrl = await uploadImage(imageFile, res.user?.id ?? "");
      print('userUpdated $imageUrl');

      final userUpdated = await supabase.auth.updateUser(
        UserAttributes(data: {"image": imageUrl}),
      );
      print('userUpdated ${userUpdated.user}');
      return Future.value(unit);
    } catch (e) {
      print('e ${e}');
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Unit> signInUser(String email, String password) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final Session? session = res.session;
      final User? user = res.user;
      if (user == null) {
        return Future.error('Error signing in: user is null');
      } else {
        return Future.value(unit);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  // Future<void> fetchUserImageUrl() async {
  //   try {
  //     final user = supabase.auth.currentUser;
  //
  //     final response = await supabase
  //         .from('profiles')
  //         .select('avatar_url')
  //         .eq('id', user?.id ?? '')
  //         .single();
  //
  //     if (response == null) {
  //       return Future.error('Error fetch User ImageUrl ');
  //     } else {
  //       return Future.value(unit);
  //     }
  //   } catch (e) {
  //     throw ServerException(message: e.toString());
  //   }
  // }

  @override
  Future<Unit> logOut() async {
    await supabase.auth.signOut();
    return Future.value(unit);
  }
}
