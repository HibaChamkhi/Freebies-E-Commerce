

import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/utils/error/failures.dart';
import '../../data/models/user.dart';

abstract class AuthRepository {
  Future<Either<Failure,Unit>> signUpUser(UserModel user,File imageFile);
  Future<Either<Failure,Unit>> signInUser(String email, String password);
  Future<Either<Failure,Unit>> logOut();
}

