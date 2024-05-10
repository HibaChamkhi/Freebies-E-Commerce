import 'package:dartz/dartz.dart';
import 'package:freebies_e_commerce/features/products/data/models/product.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/config/injection/base_api_repository.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/error/exception.dart';
import '../../../../core/utils/error/failures.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_source/supabase_data_source.dart';


@Injectable(as: ProductRepository)
class ProductRepositoryImpl extends BaseApiRepository implements ProductRepository {
  final ProductDataSource _ProductDataSource;
  // final NetworkInfo networkInfo;
  ProductRepositoryImpl(this._ProductDataSource,
      // this.networkInfo
      );

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    // if (await networkInfo.isConnected) {
      try {
        final remoteUpdateProduct =
        await _ProductDataSource.getProducts() ;
        return Right(remoteUpdateProduct);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    }
    // else {
    //   return Left(OfflineFailure());
    // }
  // }
  
}
