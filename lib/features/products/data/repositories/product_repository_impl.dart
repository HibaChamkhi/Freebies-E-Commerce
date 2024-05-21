import 'package:dartz/dartz.dart';
import 'package:freebies_e_commerce/features/products/data/models/category/category.dart';
import 'package:freebies_e_commerce/features/products/data/models/search/search.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/config/injection/base_api_repository.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/error/exception.dart';
import '../../../../core/utils/error/failures.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_source/supabase_data_source.dart';
import '../models/product/product.dart';
import '../models/sub_category/sub_category.dart';


@Injectable(as: ProductRepository)
class ProductRepositoryImpl extends BaseApiRepository implements ProductRepository {
  final ProductDataSource _ProductDataSource;
  // final NetworkInfo networkInfo;
  ProductRepositoryImpl(this._ProductDataSource,
      // this.networkInfo
      );

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts(
      ProductFetchType fetchType,
      String? searchQuery,
      String? categoryId,
      List<int>? subcategoryIds,
      ProductSortType? sortType,
      double? minPrice,
      double? maxPrice)  async {
    // if (await networkInfo.isConnected) {
      try {
        final remoteGetProducts =
        await _ProductDataSource.getProducts(fetchType,searchQuery,categoryId,subcategoryIds,sortType,minPrice,maxPrice) ;
        return Right(remoteGetProducts);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    }
  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    // if (await networkInfo.isConnected) {
      try {
        final remoteGetCategories =
        await _ProductDataSource.getCategories() ;
        return Right(remoteGetCategories);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    }
  @override
  Future<Either<Failure, List<SubCategoryModel>>> getSubCategories(String categoryId) async {
    // if (await networkInfo.isConnected) {
      try {
        final remoteGetSubCategories =
        await _ProductDataSource.getSubCategories(categoryId) ;
        return Right(remoteGetSubCategories);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    }

  @override
  Future<Either<Failure, Unit>> deleteSearchValue(int searchId) async {
    try {
      final remoteDeleteSearchValue =
          await _ProductDataSource.deleteSearchValue(searchId) ;
      return Right(remoteDeleteSearchValue);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<SearchModel>>> getSearchValue() async {
    try {
      final remoteGetSearchValue =
      await _ProductDataSource.getSearchValue() ;
      return Right(remoteGetSearchValue);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> setSearchValue(SearchModel searchValue) async {
    try {
      final remoteSetSearchValue =
      await _ProductDataSource.setSearchValue(searchValue) ;
      return Right(remoteSetSearchValue);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.message));
    }
  }
  
}
