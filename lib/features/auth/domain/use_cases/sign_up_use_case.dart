

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:freebies_e_commerce/features/auth/data/models/user.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/error/failures.dart';
import '../repositories/auth_repository.dart';

@Injectable()
class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase({required this.repository});
  Future<Either<Failure,Unit>>  call(UserModel user,File imageFile) async {
    return await repository.signUpUser(user,imageFile);
  }
}
