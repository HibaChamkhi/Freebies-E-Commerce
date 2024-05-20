

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/error/failures.dart';
import '../../data/data_source/supabase_data_source.dart';
import '../../data/models/product/product.dart';
import '../repositories/product_repository.dart';

@Injectable()
class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase({required this.repository});

  Future<Either<Failure, List<ProductModel>>> call(
      ProductFetchType fetchType,
      String? searchQuery,
      String? categoryId,
      String? subcategoryId,
      ProductSortType? sortType)  async {
    return await repository.getProducts(fetchType,searchQuery,categoryId,subcategoryId,sortType);
  }
}
