import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/error/failures.dart';
import '../../data/models/news.dart';
import '../repositories/news_repository.dart';

@Injectable()
class GetNewsUseCase {
  final NewsRepository repository;

  GetNewsUseCase({required this.repository});

  Future<Either<Failure, List<NewsModel>>> call() async {
    return await repository.getAllNews();
  }
}
