import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:freebies_e_commerce/features/products/data/models/product/product.dart';
import 'package:freebies_e_commerce/features/products/data/models/search/search.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dio/dio.dart';

import '../../../../core/utils/error/exception.dart';
import '../models/category/category.dart';
import '../models/sub_category/sub_category.dart';

enum ProductFetchType {
  all,
  newProducts,
  productsWithSpecialOffers,
  bestSellers,
  topRated,
  byCategory,
  // subCategories
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
      List<int>? subcategoryIds,
      ProductSortType? sortType,
      double? minPrice, // Add this line for minimum price
      double? maxPrice);

  Future<List<CategoryModel>> getCategories();

  Future<List<SubCategoryModel>> getSubCategories(String categoryId);

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
      List<int>? subcategoryIds,
      ProductSortType? sortType,
      double? minPrice,
      double? maxPrice) async {
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

      if (minPrice != null && maxPrice != null) {
        if (searchQuery != null && searchQuery.isNotEmpty) {
          response = await supabase
              .from('products')
              .select('*')
              .eq('category_id', categoryId ?? "")
              .ilike('name', '%$searchQuery%')
              .gte('price', minPrice) // Add this line for minimum price
              .lte('price', maxPrice); // Add this line for maximum price
        } else {
          response = await supabase
              .from('products')
              .select('*')
              .eq('category_id', categoryId ?? "")
              .gte('price', minPrice) // Add this line for minimum price
              .lte('price', maxPrice);
        }
      }

      if (subcategoryIds != null && subcategoryIds.isNotEmpty) {
        if (searchQuery != null && searchQuery.isNotEmpty) {
          response = await supabase
              .from('products')
              .select('*')
              .filter('subcategory_id', 'in', subcategoryIds)
              .ilike('name', '%$searchQuery%');
          // .gte('price', minPrice!) // Add this line for minimum price
          // .lte('price', maxPrice!); // Add this line for maximum price
        } else {
          response = await supabase
              .from('products')
              .select('*')
              .filter('subcategory_id', 'in', subcategoryIds);
          // .gte('price', minPrice!) // Add this line for minimum price
          // .lte('price', maxPrice!); // Add this line for maximum price
        }
      }

      // Apply sorting
      if (sortType != null) {
        switch (sortType) {
          case ProductSortType.nameAsc:
            response.sort((a, b) => a['name'].compareTo(b['name']));
            break;
          case ProductSortType.nameDesc:
            response.sort((a, b) => b['name'].compareTo(a['name']));

            break;
          case ProductSortType.priceHighToLow:
            response.sort((a, b) => b['price'].compareTo(a['price']));
            break;
          case ProductSortType.priceLowToHigh:
            response.sort((a, b) => a['price'].compareTo(b['price']));
            break;
        }
      }
      var products = response
          .map((productData) => ProductModel.fromJson(productData))
          .toList();
      return products;
    } catch (e) {
      ServerException(message: e.toString());
      return [];
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      List<Map<String, dynamic>> response =
          await supabase.from('categories').select('*');
      var products = response
          .map((categoryData) => CategoryModel.fromJson(categoryData))
          .toList();

      return products;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<SubCategoryModel>> getSubCategories(String categoryId) async {
    try {
      List<Map<String, dynamic>> response = await supabase
          .from('sub_categories')
          .select('*')
          .eq('category_id', categoryId);
      var products = response
          .map((categoryData) => SubCategoryModel.fromJson(categoryData))
          .toList();

      return products;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Unit> setSearchValue(SearchModel searchValue) async {
    Session? session = supabase.auth.currentSession;

    try {
      final response = await supabase.from('search').insert(
          {'user_id': session?.user.id ?? "", 'text': searchValue.text});


      if (response.error != null) {
        // Handle error
        return unit; // Assuming unit is defined somewhere in your code
      } else {
        // Data inserted successfully
        return unit;
      }
    } catch (e) {
      throw ServerException(message: e.toString());
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
        return products;
      } else {
        return [];
      }
    } catch (e) {
      throw ServerException(message: e.toString());
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
          return unit;
        } else {
          return unit;
        }
      } else {
        return unit;
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
