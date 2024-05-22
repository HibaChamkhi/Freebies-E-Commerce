

import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/utils/error/failures.dart';
import '../../data/models/news.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsModel>>> getAllNews();
}

