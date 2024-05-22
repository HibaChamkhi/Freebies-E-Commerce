import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freebies_e_commerce/core/utils/error/exception.dart';
import 'package:freebies_e_commerce/core/utils/error/failures.dart';
import 'package:freebies_e_commerce/features/auth/data/models/user.dart';
import 'package:freebies_e_commerce/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  const loginParams = {'email': 'User3@User.com', 'password': 'UserPassword'};

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockAuthDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource , mockNetworkInfo,);
  });
  var file = File(
      "https://gwdhzjaemtwtodlesqrw.supabase.co/storage/v1/object/public/news_images/Image_news5.png");
  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////
  group('login', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(mockRemoteDataSource.signInUser(
      'User3@User.com',
      'UserPassword',
      )).thenAnswer((_) async => unit);

      // act
      await repository.signInUser(
         loginParams['email']!,
      loginParams['password']!,
      );

      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.signInUser(
        'User3@User.com',
    'UserPassword',
      ));
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
              () async {
            /// arrange
            when(mockRemoteDataSource.signInUser(
            loginParams['email']!,
           loginParams['password']!,
            )).thenAnswer((_) async => unit);

            /// act
            final result = await repository.signInUser(
             loginParams['email']!,
             loginParams['password']!,
            );

            /// assert
            verify(mockRemoteDataSource.signInUser(
             loginParams['email']!,
              loginParams['password']!,
            ));
            expect(result, equals(const Right(unit)));
          });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
              () async {
            /// arrange
            when(mockRemoteDataSource.signInUser(
            loginParams['email']!,
               loginParams['password']!,
            )).thenThrow(ServerException(message: 'server exception'));

            /// act
            final result = await repository.signInUser(
             loginParams['email']!,
           loginParams['password']!,
            );

            /// assert
            verify(mockRemoteDataSource.signInUser(
             loginParams['email']!,
              loginParams['password']!,
            ));

            expect(
                result, equals(Left(ServerFailure(message: 'server exception'))));
          });
    });
  });

  

  ////////////////////////////////////////////////////////////////////////////////////////////////
  group('get createAccount response', () {
    const UserModel userModel = UserModel(
        email: 'email',
        password: 'password',
        username: '');

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(mockRemoteDataSource.signUpUser(userModel,file))
          .thenAnswer((_) async => unit);

      // act
      await repository.signUpUser(userModel,file);

      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.signUpUser(userModel,file));
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
              () async {
            /// arrange
            when(mockRemoteDataSource.signUpUser(userModel,file))
                .thenAnswer((_) async => unit);

            /// act
            final result = await repository.signUpUser(userModel,file);

            /// assert
            verify(mockRemoteDataSource.signUpUser(userModel,file));
            expect(result, equals(const Right(unit)));
          });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
              () async {
            /// arrange
            when(mockRemoteDataSource.signUpUser(userModel,file))
                .thenThrow(ServerException(message: 'server exception'));

            /// act
            final result = await repository.signUpUser(userModel,file);

            /// assert
            verify(mockRemoteDataSource.signUpUser(userModel,file));

            expect(
                result, equals(Left(ServerFailure(message: 'server exception'))));
          });
    });
  });


}
