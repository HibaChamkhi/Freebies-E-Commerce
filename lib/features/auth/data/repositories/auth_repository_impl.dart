import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:freebies_e_commerce/features/auth/data/models/user.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/config/injection/base_api_repository.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/error/exception.dart';
import '../../../../core/utils/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_source/supabase_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends BaseApiRepository implements AuthRepository {
  final AuthDataSource _authDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(this._authDataSource, this.networkInfo);

  @override
  Future<Either<Failure, Unit>> signUpUser(
      UserModel user, File imageFile) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUpdateAuth =
            await _authDataSource.signUpUser(user, imageFile);
        return Right(remoteUpdateAuth);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  Future<Either<Failure, Unit>> signInUser(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUpdateAuth =
            await _authDataSource.signInUser(email, password);
        return Right(remoteUpdateAuth);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  Future<Either<Failure, Unit>> logOut() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUpdateAuth = await _authDataSource.logOut();
        return Right(remoteUpdateAuth);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
