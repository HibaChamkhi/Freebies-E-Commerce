

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/error/failures.dart';
import '../../data/models/product.dart';
import '../repositories/product_repository.dart';

@Injectable()
class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase({required this.repository});

  Future<Either<Failure, List<ProductModel>>> call() async {
    return await repository.getProducts();
  }
}
