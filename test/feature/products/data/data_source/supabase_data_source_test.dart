import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freebies_e_commerce/features/products/data/data_source/supabase_data_source.dart';
import 'package:freebies_e_commerce/features/products/data/models/category/category.dart';
import 'package:freebies_e_commerce/features/products/data/models/product/product.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late ProductDataSource dataSource;

  setUp(() {
    dataSource = MockProductDataSource();
  });

  test('create product should complete without errors', () async {
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

    when(dataSource.getProducts(
            ProductFetchType.all, null, null, null, null, null, null))
        .thenAnswer((_) async => products);

    final result = await dataSource.getProducts(
        ProductFetchType.all, null, null, null, null, null, null);

    expect(result, products);
  });
}
