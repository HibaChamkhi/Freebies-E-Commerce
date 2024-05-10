

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/error/failures.dart';
import '../repositories/auth_repository.dart';

@Injectable()
class LogOutUseCase {
  final AuthRepository repository;

  LogOutUseCase({required this.repository});
  Future<Either<Failure,Unit>>  call() async {
    return await repository.logOut();
  }
}
