import 'package:dartz/dartz.dart';
import 'package:freebies_e_commerce/features/products/data/models/category/category.dart';
import 'package:freebies_e_commerce/features/products/data/models/search/search.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/error/failures.dart';
import '../repositories/product_repository.dart';

@Injectable()
class GetSearchValueUseCase {
  final ProductRepository repository;

  GetSearchValueUseCase({required this.repository});

  Future<Either<Failure, List<SearchModel>>> call() async {
    return await repository.getSearchValue();
  }
}
