import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freebies_e_commerce/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:freebies_e_commerce/features/news/data/models/news.dart';
import 'package:freebies_e_commerce/features/news/domain/use_cases/get_news_use_case.dart';
import 'package:freebies_e_commerce/features/products/data/data_source/supabase_data_source.dart';
import 'package:freebies_e_commerce/features/products/data/models/product/product.dart';
import 'package:freebies_e_commerce/features/products/domain/use_cases/get_products_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockProductRepository productRepository;
  late GetProductsUseCase getProductsUseCase;
  const products = [
    ProductModel(
      name: "name",
      description: "description",
      id: 3,
      createdAt: '',
      price: 3,
      image: '',
      num_rating: 3,
    )
  ];
  setUp(() {
    productRepository = MockProductRepository();
    getProductsUseCase = GetProductsUseCase( repository: productRepository);
  });

  test("should get get All products from the repository", () async {
    /// arrange
    when(productRepository.getProducts(
        ProductFetchType.all, null, null, null, null, null, null))
        .thenAnswer((dataJson) async => const Right(products));

    /// act
    final result = await getProductsUseCase.call(ProductFetchType.all, null, null, null, null, null, null);

    /// assert
    expect(result, equals(const Right(products)));
  });
}
