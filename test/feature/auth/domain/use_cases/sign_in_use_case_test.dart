import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freebies_e_commerce/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignInUseCase signInUseCase;
  const loginParams =
  {'email': 'test@test.com', 'password': '12345678'};

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signInUseCase = SignInUseCase(repository: mockAuthRepository);
  });

  test("should get login from the repository", () async {
    /// arrange
    when(mockAuthRepository.signInUser( loginParams['email'],  loginParams['password']))
        .thenAnswer((dataJson) async => const Right(unit));

    /// act
    final result = await signInUseCase.call( loginParams['email']!, loginParams['password']!);

    /// assert
    expect(result, equals(const Right(unit)));
  });
}
