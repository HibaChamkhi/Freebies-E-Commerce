import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/utils/error/exception.dart';
import '../models/news.dart';

abstract class NewsDataSource {
  Future<List<NewsModel>> getAllNews();

}

@Injectable(as: NewsDataSource)
class NewsRemoteDataSourceImpl implements NewsDataSource {
  NewsRemoteDataSourceImpl();
  final supabase = Supabase.instance.client;

  @override
  Future<List<NewsModel>> getAllNews() async {
    try {
      List<Map<String, dynamic>> response =
      await supabase.from('news').select('*');
      var products = response
          .map((categoryData) => NewsModel.fromJson(categoryData))
          .toList();
      return products;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }


}

