

import 'package:dartz/dartz.dart';
import '../../../../core/utils/error/failures.dart';
import '../../data/models/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>>getProducts();
}

