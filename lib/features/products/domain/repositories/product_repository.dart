

import 'package:dartz/dartz.dart';
import 'package:freebies_e_commerce/features/products/data/models/category/category.dart';
import '../../../../core/utils/error/failures.dart';
import '../../data/data_source/supabase_data_source.dart';
import '../../data/models/product/product.dart';
import '../../data/models/search/search.dart';
import '../../data/models/sub_category/sub_category.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>>getProducts(
      ProductFetchType fetchType,
      String? searchQuery,
      String? categoryId,
      List<int>? subcategoryIds,
      ProductSortType? sortType,
      double? minPrice,
      double? maxPrice) ;
  Future<Either<Failure, List<CategoryModel>>>getCategories();
  Future<Either<Failure, List<SubCategoryModel>>>getSubCategories(String categoryId);
  Future<Either<Failure, List<SearchModel>>>getSearchValue();
  Future<Either<Failure, Unit>>setSearchValue(SearchModel searchValue);
  Future<Either<Failure, Unit>>deleteSearchValue(int searchId);
}

