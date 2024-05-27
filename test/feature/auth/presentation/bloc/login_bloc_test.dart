import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freebies_e_commerce/core/utils/error/failures.dart';
import 'package:freebies_e_commerce/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';


void main() {
  late LoginBloc loginBloc;
  late MockSignInUseCase mockSignInUseCase;
  late MockLogOutUseCase mockLogOutUseCase;

  setUp(() {
    mockSignInUseCase = MockSignInUseCase();
    mockLogOutUseCase = MockLogOutUseCase();

    loginBloc = LoginBloc(
    signInUseCase: mockSignInUseCase, logOutUseCase: mockLogOutUseCase,
    );
  });

  group('login useCase', () {
    String email = 'User3@User.com';
    String password = 'UserPassword';

    test('should get data from the concrete useCase', () async* {
      //arrange
      when(mockSignInUseCase(any,  any))
          .thenAnswer((_) async => const Right(unit));

      //act
      loginBloc.add(LoginUserEvent(email: email, password: password));
      await untilCalled(mockSignInUseCase( any, any));

      //assert
      verify(mockSignInUseCase( email,password));
    });

    test(
        'should emits [Loading, Authenticated] when data is gotten successfully',
            () async* {
          //arrange
          when(mockSignInUseCase(any, any))
              .thenAnswer((_) async => const Right(unit));

          //assert later
          final expected = [
            const LoginState(loginStatus: LoginStatus.error),
            const LoginState(loginStatus: LoginStatus.loading),
            const LoginState(loginStatus: LoginStatus.success),
          ];
          expectLater(loginBloc, emitsInOrder(expected));
          //act
          loginBloc.add(LoginUserEvent(email: email, password: password));
        });

    test('should emits [Loading, AuthError] when getting data fails',
            () async* {
          //arrange
          when(mockSignInUseCase(any, any)).thenAnswer(
                  (_) async => Left(ServerFailure(message: "Server issue, please try again later.")));

          //assert later
          final expected = [
            const LoginState(loginStatus: LoginStatus.error),
            const LoginState(loginStatus: LoginStatus.loading),
            const LoginState(loginStatus: LoginStatus.success),
          ];
          expectLater(loginBloc, emitsInOrder(expected));
          //act
          loginBloc.add(LoginUserEvent(email: email, password: password));
        });
  });
}
