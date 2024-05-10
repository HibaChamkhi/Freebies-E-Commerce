import 'dart:async';
import 'package:freebies_e_commerce/features/products/data/models/product.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dio/dio.dart';

abstract class ProductDataSource {
  ProductDataSource(Dio dio);

  Future<List<ProductModel>> getProducts();
}

@Injectable(as: ProductDataSource)
class RemoteDataSourceImpl implements ProductDataSource {
  RemoteDataSourceImpl();

  final supabase = Supabase.instance.client;

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      List<Map<String, dynamic>> response = await supabase.from('products').select('*');
      print("response $response");
     var products = response.map((productData) => ProductModel.fromJson(productData)).toList();
      print("products ${response.map((productData) => ProductModel.fromJson(productData)).toList()}");
      return products;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
}
