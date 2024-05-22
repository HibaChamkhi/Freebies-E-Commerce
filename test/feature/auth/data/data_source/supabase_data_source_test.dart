import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freebies_e_commerce/features/auth/data/models/user.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  group('AuthDataSource', () {
    late MockAuthDataSource dataSource;
    const email = 'test@test.com';
    const password = 'password';

    setUp(() {
      dataSource = MockAuthDataSource();
    });

    test('login should return unit', () async {
      when(dataSource.signInUser(email, password))
          .thenAnswer((_) async => unit);
      final result = await dataSource.signInUser(email, password);
      expect(result, unit);
    });

    test('create account should complete without errors', () async {
      const userModel = UserModel(email: '', password: '', username: '');
      var file = File(
          "https://gwdhzjaemtwtodlesqrw.supabase.co/storage/v1/object/public/news_images/Image_news5.png");
      when(dataSource.signUpUser(userModel, file))
          .thenAnswer((_) async => unit);

      final result = await dataSource.signUpUser(userModel, file);

      expect(result, unit);
    });
  });
}
