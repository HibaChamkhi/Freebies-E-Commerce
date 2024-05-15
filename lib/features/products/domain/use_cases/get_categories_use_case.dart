import 'package:dartz/dartz.dart';
import 'package:freebies_e_commerce/features/products/data/models/category.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/error/failures.dart';
import '../../data/models/product.dart';
import '../repositories/product_repository.dart';

@Injectable()
class GetCategoriesUseCase {
  final ProductRepository repository;

  GetCategoriesUseCase({required this.repository});

  Future<Either<Failure, List<CategoryModel>>> call() async {
    return await repository.getCategories();
  }
}
