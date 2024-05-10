

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/error/failures.dart';
import '../repositories/auth_repository.dart';

@Injectable()
class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase({required this.repository});
  Future<Either<Failure,Unit>>  call(String email, String password) async {
    return await repository.signInUser(email, password);
  }
}
