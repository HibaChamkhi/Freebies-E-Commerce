import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freebies_e_commerce/features/auth/data/models/user.dart';
import 'package:freebies_e_commerce/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignUpUseCase signUpUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signUpUseCase = SignUpUseCase(repository: mockAuthRepository);
  });

  test("should get login from the repository", () async {
    UserModel userModel = const UserModel(
        email: 'test@test.com',
        password: '12345678',
         username: '');
    var file = File("https://gwdhzjaemtwtodlesqrw.supabase.co/storage/v1/object/public/news_images/Image_news5.png");
    /// arrange
    when(mockAuthRepository.signUpUser( userModel, file))
        .thenAnswer((dataJson) async => const Right(unit));

    /// act
    final result = await signUpUseCase.call(userModel, file);

    /// assert
    expect(result, equals(const Right(unit)));
  });
}


