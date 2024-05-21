import 'package:dartz/dartz.dart';
import 'package:freebies_e_commerce/features/products/data/models/category/category.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/error/failures.dart';
import '../../data/models/sub_category/sub_category.dart';
import '../repositories/product_repository.dart';

@Injectable()
class GetSubCategoriesUseCase {
  final ProductRepository repository;

  GetSubCategoriesUseCase({required this.repository});

  Future<Either<Failure, List<SubCategoryModel>>> call(String categoryId) async {
    return await repository.getSubCategories(categoryId);
  }
}
