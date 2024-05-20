import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:freebies_e_commerce/features/products/data/models/product/product.dart';
import 'package:freebies_e_commerce/features/products/data/models/search/search.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dio/dio.dart';

import '../models/category/category.dart';

enum ProductFetchType {
  all,
  newProducts,
  productsWithSpecialOffers,
  bestSellers,
  topRated,
  byCategory
}

enum ProductSortType {
  nameAsc,
  nameDesc,
  priceHighToLow,
  priceLowToHigh,
}

abstract class ProductDataSource {
  Future<List<ProductModel>> getProducts(
      ProductFetchType fetchType,
      String? searchQuery,
      String? categoryId,
      String? subcategoryId,
      ProductSortType? sortType);

  Future<List<CategoryModel>> getCategories();

  Future<List<SearchModel>> getSearchValue();

  Future<Unit> setSearchValue(SearchModel searchValue);

  Future<Unit> deleteSearchValue(int searchId);
}

@Injectable(as: ProductDataSource)
class RemoteDataSourceImpl implements ProductDataSource {
  RemoteDataSourceImpl();

  final supabase = Supabase.instance.client;

  @override
  Future<List<ProductModel>> getProducts(
      ProductFetchType fetchType,
      String? searchQuery,
      String? categoryId,
      String? subcategoryId,
      ProductSortType? sortType) async {
    try {
      List<Map<String, dynamic>> response;

      switch (fetchType) {
        case ProductFetchType.all:
          if (searchQuery != null && searchQuery.isNotEmpty) {
            response = await supabase
                .from('products')
                .select('*')
                .ilike('name', '%$searchQuery%');
          } else {
            response = await supabase.from('products').select('*');
          }
          break;
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
          response = await supabase
              .from('products')
              .select('*')
              .order('num_sellers', ascending: false)
              .limit(3);
          break;
        case ProductFetchType.topRated:
          response = await supabase
              .from('products')
              .select('*')
              .order('num_rating', ascending: false)
              .limit(3);
          break;
        case ProductFetchType.byCategory:
          if (searchQuery != null && searchQuery.isNotEmpty) {
            response = await supabase
                .from('products')
                .select('*')
                .eq('category_id', categoryId ?? "")
                .ilike('name', '%$searchQuery%');
          } else {
            response = await supabase
                .from('products')
                .select('*')
                .eq('category_id', categoryId ?? "");
          }
          break;
      }
      print("sortType $sortType");
      // Apply sorting
      if (sortType != null) {
        switch (sortType) {
          case ProductSortType.nameAsc:
            response.sort((a, b) => a['name'].compareTo(b['name']));
            print("response nameAsc $response") ;
            break;
          case ProductSortType.nameDesc:
            response.sort((a, b) => b['name'].compareTo(a['name']));
            print("response nameDesc $response") ;

            break;
          case ProductSortType.priceHighToLow:
            response.sort((a, b) => b['price'].compareTo(a['price']));
            break;
          case ProductSortType.priceLowToHigh:
            response.sort((a, b) => a['price'].compareTo(b['price']));
            break;
        }
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

  @override
  Future<Unit> setSearchValue(SearchModel searchValue) async {
    Session? session = supabase.auth.currentSession;

    try {
      final response = await supabase.from('search').insert(
          {'user_id': session?.user.id ?? "", 'text': searchValue.text});

      print("setSearchValue response $response");

      if (response.error != null) {
        // Handle error
        print('Error inserting data: ${response.error!.message}');
        return unit; // Assuming unit is defined somewhere in your code
      } else {
        // Data inserted successfully
        print('Data inserted successfully');
        return unit;
      }
    } catch (e) {
      print('Error inserting data: $e');
      return unit;
    }
  }

  @override
  Future<List<SearchModel>> getSearchValue() async {
    try {
      final user = supabase.auth.currentUser;
      final userId = user?.id;

      if (userId != null) {
        final response =
            await supabase.from('search').select('*').eq('user_id', userId);
        var products = response
            .map((categoryData) => SearchModel.fromJson(categoryData))
            .toList();
        print("categories $products");
        return products;
      } else {
        print('User not authenticated');
        return [];
      }
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  @override
  Future<Unit> deleteSearchValue(int searchId) async {
    try {
      final user = supabase.auth.currentUser;
      final userId = user?.id;
      if (userId != null) {
        final response = await supabase
            .from('search')
            .delete()
            .eq('user_id', userId)
            .eq('id', searchId);
        if (response.error != null) {
          print('Error deleting search value: ${response.error!.message}');
          return unit;
        } else {
          // Search value deleted successfully
          print('Search value deleted successfully');
          return unit;
        }
      } else {
        print('User not authenticated');
        return unit;
      }
    } catch (e) {
      print('Error deleting search value: $e');
      return unit;
    }
  }
}
