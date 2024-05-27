import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freebies_e_commerce/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:freebies_e_commerce/features/news/data/models/news.dart';
import 'package:freebies_e_commerce/features/news/domain/use_cases/get_news_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockNewsRepository mockNewsRepository;
  late GetNewsUseCase getNewsUseCaseCase;
 const news = [NewsModel(title: 'title', description: 'description', image: 'image', created_at: 'created_at')];
  setUp(() {
    mockNewsRepository = MockNewsRepository();
    getNewsUseCaseCase = GetNewsUseCase(repository: mockNewsRepository);
  });

  test("should get get All News from the repository", () async {
    /// arrange
    when(mockNewsRepository.getAllNews())
        .thenAnswer((dataJson) async => const Right(news));

    /// act
    final result = await getNewsUseCaseCase.call();

    /// assert
    expect(result, equals(const Right(news)));
  });
}
