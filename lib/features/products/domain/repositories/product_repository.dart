

import 'package:dartz/dartz.dart';
import 'package:freebies_e_commerce/features/products/data/models/category.dart';
import '../../../../core/utils/error/failures.dart';
import '../../data/data_source/supabase_data_source.dart';
import '../../data/models/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>>getProducts(ProductFetchType fetchType,String? searchQuery);
  Future<Either<Failure, List<CategoryModel>>>getCategories();
}

