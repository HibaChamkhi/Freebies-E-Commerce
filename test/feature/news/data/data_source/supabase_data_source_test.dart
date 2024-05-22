import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freebies_e_commerce/features/auth/data/models/user.dart';
import 'package:freebies_e_commerce/features/news/data/models/news.dart';
import 'package:freebies_e_commerce/features/news/data/repositories/news_repository_impl.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  group('NewsDataSource', () {
    late MockNewsDataSource dataSource;
    const newsModel = [NewsModel(title: '', description: '', image: '', created_at: '')];

    setUp(() {
      dataSource = MockNewsDataSource();
    });

    test('get All News should return unit', () async {
      when(dataSource.getAllNews())
          .thenAnswer((_) async => newsModel);
      final result = await dataSource.getAllNews();
      expect(result, newsModel);
    });

  });
}
