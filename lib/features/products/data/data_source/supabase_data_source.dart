import 'dart:async';
import 'package:freebies_e_commerce/features/products/data/models/product.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dio/dio.dart';

import '../models/category.dart';

enum ProductFetchType {
  all,
  newProducts,
  productsWithSpecialOffers,
  bestSellers,
  topRated
}

abstract class ProductDataSource {
  ProductDataSource(Dio dio);

  Future<List<ProductModel>> getProducts(ProductFetchType fetchType,String? searchQuery);

  Future<List<CategoryModel>> getCategories();
}

@Injectable(as: ProductDataSource)
class RemoteDataSourceImpl implements ProductDataSource {
  RemoteDataSourceImpl();

  final supabase = Supabase.instance.client;

  @override
  Future<List<ProductModel>> getProducts(ProductFetchType fetchType ,String? searchQuery) async {
    try {
      List<Map<String, dynamic>> response;

      switch (fetchType) {
        case ProductFetchType.all:
          if (searchQuery != null && searchQuery.isNotEmpty) {
            response = await supabase.from('products').select('*').ilike('name', '%$searchQuery%');
          } else {
            response = await supabase.from('products').select('*');
          }          break;
        case ProductFetchType.newProducts:
          DateTime cutoffDate = DateTime.now().subtract(Duration(days: 1));
          response = await supabase
              .from('products')
              .select('*')
              .filter('createdAt', 'gte', cutoffDate);
          break;
        case ProductFetchType.productsWithSpecialOffers:
          response = await supabase
              .from('products')
              .select('*')
              .not('discount', 'is', null);
          break;
        case ProductFetchType.bestSellers:
          response = await supabase.from('products').select('*').order('num_sellers', ascending: false).limit(3);
          break;
        case ProductFetchType.topRated:
          response = await supabase.from('products').select('*').order('num_rating', ascending: false).limit(3);
          break;
      }

      print("response $response");

      var products = response
          .map((productData) => ProductModel.fromJson(productData))
          .toList();
      print("products $products");

      return products;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      List<Map<String, dynamic>> response =
          await supabase.from('categories').select('*');
      print("categories response $response");
      var products = response
          .map((categoryData) => CategoryModel.fromJson(categoryData))
          .toList();
      print(
          "categories ${response.map((categoryData) => CategoryModel.fromJson(categoryData)).toList()}");
      return products;
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }
}
