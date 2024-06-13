import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freebies_e_commerce/features/products/data/data_source/supabase_data_source.dart';
import 'package:freebies_e_commerce/features/products/data/models/category/category.dart';
import 'package:freebies_e_commerce/features/products/data/models/product/product.dart';
import 'package:freebies_e_commerce/features/products/data/models/sub_category/sub_category.dart';
import 'package:freebies_e_commerce/features/products/data/repositories/product_repository_impl.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';



void main(){
  late MockProductDataSource mockProductRemoteDataSource ;
  late ProductRepositoryImpl productRepositoryImpl ;
  late MockNetworkInfo mockNetworkInfo;

  const testCategoryModel = [CategoryModel( name: "Audio", id: 9, image: '')];
  const testSubCategoryModel = [SubCategoryModel( name: "Audio", id: 9,category_id: 9)];
  const testProductModel =
[  ProductModel(
    name: "name",
    description: "description",
    id: 3,
    createdAt: '',
    price: 3,
    image: '',
    num_rating: 3,
  )];

  setUp(() {
    mockProductRemoteDataSource = MockProductDataSource();
    mockNetworkInfo = MockNetworkInfo();
    productRepositoryImpl = ProductRepositoryImpl( mockProductRemoteDataSource,  mockNetworkInfo);
  });

  group("product repository", () {
    //add product
    test("should return unit when a call to data source is successful", () async {
      // Arrange: Stub the isConnected method of mockNetworkInfo
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(mockProductRemoteDataSource.getProducts(
          ProductFetchType.all, null, null, null, null, null, null))
          .thenAnswer((_) async => testProductModel);

      // act
      final result = await productRepositoryImpl.getProducts(
          ProductFetchType.all, null, null, null, null, null, null);
      // assert
      expect(result, equals(const Right(testProductModel)));
    });



    //get category
    test("should return category when a call to data source is successful", () async {
      // Arrange: Stub the isConnected method of mockNetworkInfo
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(mockProductRemoteDataSource.getCategories())
          .thenAnswer((_) async => testCategoryModel);

      // act
      final result = await productRepositoryImpl.getCategories();
      // assert
      expect(result, equals(const Right(testCategoryModel)));
    });
    //get sup category
    test("should return sup category when a call to data source is successful", () async {
      // Arrange: Stub the isConnected method of mockNetworkInfo
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(mockProductRemoteDataSource.getSubCategories("33"))
          .thenAnswer((_) async => testSubCategoryModel);

      // act
      final result = await productRepositoryImpl.getSubCategories("33");
      // assert
      expect(result, equals(const Right(testSubCategoryModel)));
    });

  });

}
