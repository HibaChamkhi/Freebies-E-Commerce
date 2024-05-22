
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freebies_e_commerce/features/news/data/models/news.dart';
import 'package:freebies_e_commerce/features/news/data/repositories/news_repository_impl.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockNewsDataSource dataSource;
  late NewsRepositoryImpl newsRepositoryImpl ;
  late MockNetworkInfo mockNetworkInfo;
  const newsModel = [NewsModel(title: '', description: '', image: '', created_at: '')];

  setUp(() {
    dataSource = MockNewsDataSource();
    mockNetworkInfo = MockNetworkInfo();
    newsRepositoryImpl = NewsRepositoryImpl(dataSource,mockNetworkInfo);

  });

  test("should return delivered orders when a call to data source is successful", () async {
    // Arrange: Stub the isConnected method of mockNetworkInfo
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

    when(dataSource.getAllNews())
        .thenAnswer((_) async => newsModel);

    // act
    final result = await newsRepositoryImpl.getAllNews();
    // assert
    expect(result, equals(const Right(newsModel)));
  });

}
