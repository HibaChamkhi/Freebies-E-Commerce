import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:freebies_e_commerce/features/news/data/models/news.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/config/injection/base_api_repository.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/error/exception.dart';
import '../../../../core/utils/error/failures.dart';
import '../../domain/repositories/news_repository.dart';
import '../data_source/supabase_data_source.dart';


@Injectable(as: NewsRepository)
class NewsRepositoryImpl extends BaseApiRepository implements NewsRepository {
  final NewsDataSource _NewsDataSource;
  // final NetworkInfo networkInfo;
  NewsRepositoryImpl(this._NewsDataSource,
      // this.networkInfo
      );

  @override
  Future<Either<Failure, List<NewsModel>>> getAllNews() async {
    try {
      final remoteGetNews =
      await _NewsDataSource.getAllNews() ;
      return Right(remoteGetNews);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.message));
    }
  }
  
}
