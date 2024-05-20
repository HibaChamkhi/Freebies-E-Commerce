import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freebies_e_commerce/features/products/data/models/category/category.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/extensions/map_failure_to_message.dart';
import '../../data/data_source/supabase_data_source.dart';
import '../../data/models/product/product.dart';
import '../../domain/use_cases/get_categories_use_case.dart';
import '../../domain/use_cases/get_products_use_case.dart';

part 'product_event.dart';

part 'product_state.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  ProductBloc({
    required this.getProductsUseCase,
    required this.getCategoriesUseCase,
  })
      : super(const ProductState()) {
    on<ProductEvent>((event, emit) async {
      ///search
      if (event is SearchProductByCategoryEvent) {
        emit(state.copyWith(productsStatus: ProductsStatus.loading, products: []));

        final failureOrSuggestedProducts = await getProductsUseCase(ProductFetchType.byCategory,event.query,event.id,null,null);
        failureOrSuggestedProducts.fold(
                (suggestedOrFailure) => emit(state.copyWith(
              messages: mapFailureToMessage(suggestedOrFailure),
                  productsStatus: ProductsStatus.error,
            )),
                (products)
            {
              print(products);
              emit(state.copyWith(
                  productsStatus: ProductsStatus.success,
                  products: products));
            });
      }
      ///all the products
      if (event is GetAllProductsEvent) {
        emit(state.copyWith(productsStatus: ProductsStatus.loading, products: []));

        final failureOrSuggestedProducts = await getProductsUseCase(ProductFetchType.all,null,null,null,null);
        failureOrSuggestedProducts.fold(
            (suggestedOrFailure) => emit(state.copyWith(
                  messages: mapFailureToMessage(suggestedOrFailure),
                  productsStatus: ProductsStatus.error,
                )),
            (products) => emit(state.copyWith(
                productsStatus: ProductsStatus.success, products: products)));
      }
      /// the new products
      if (event is GetNewProductsEvent) {
        emit(state.copyWith(productsStatus: ProductsStatus.loading, newProducts: []));

        final failureOrSuggestedProducts = await getProductsUseCase(ProductFetchType.newProducts,null,null,null,null);
        failureOrSuggestedProducts.fold(
                (suggestedOrFailure) => emit(state.copyWith(
              messages: mapFailureToMessage(suggestedOrFailure),
              productsStatus: ProductsStatus.error,
            )),
                (products) => emit(state.copyWith(
                productsStatus: ProductsStatus.success, newProducts: products)));
      }

      /// the products With Special Offers
      if (event is GetProductsWithSpecialOffersEvent) {
        emit(state.copyWith(productsStatus: ProductsStatus.loading, productsWithSpecialOffers: []));

        final failureOrSuggestedProducts = await getProductsUseCase(ProductFetchType.productsWithSpecialOffers,null,null,null,null);
        failureOrSuggestedProducts.fold(
                (suggestedOrFailure) => emit(state.copyWith(
              messages: mapFailureToMessage(suggestedOrFailure),
              productsStatus: ProductsStatus.error,
            )),
                (products) => emit(state.copyWith(
                productsStatus: ProductsStatus.success, productsWithSpecialOffers: products)));
      }

      /// the best Sellers products
      if (event is GetBestSellersEvent) {
        emit(state.copyWith(productsStatus: ProductsStatus.loading, bestSellers: []));

        final failureOrSuggestedProducts = await getProductsUseCase(ProductFetchType.bestSellers,null,null,null,null);
        failureOrSuggestedProducts.fold(
                (suggestedOrFailure) => emit(state.copyWith(
              messages: mapFailureToMessage(suggestedOrFailure),
              productsStatus: ProductsStatus.error,
            )),
                (products) => emit(state.copyWith(
                productsStatus: ProductsStatus.success, bestSellers: products)));
      }
      /// the best Sellers products
      if (event is GetTopRatedProductsEvent) {
        emit(state.copyWith(productsStatus: ProductsStatus.loading, topRatedProducts: []));

        final failureOrSuggestedProducts = await getProductsUseCase(ProductFetchType.topRated,null,null,null,null);
        failureOrSuggestedProducts.fold(
                (suggestedOrFailure) => emit(state.copyWith(
              messages: mapFailureToMessage(suggestedOrFailure),
              productsStatus: ProductsStatus.error,
            )),
                (products) => emit(state.copyWith(
                productsStatus: ProductsStatus.success, topRatedProducts: products)));
      }

      if (event is GetAllCategoriesEvent) {
        emit(state.copyWith(categoriesStatus: CategoriesStatus.loading, products: []));

        final failureOrSuggestedProducts = await getCategoriesUseCase();
        failureOrSuggestedProducts.fold(
            (suggestedOrFailure) => emit(state.copyWith(
                  messages: mapFailureToMessage(suggestedOrFailure),
              categoriesStatus: CategoriesStatus.error,
                )),
            (categories) => emit(state.copyWith(
                categoriesStatus: CategoriesStatus.success, categories: categories)));
      }

      if (event is GetProductsByCategoryEvent) {
        emit(state.copyWith(productsStatus: ProductsStatus.loading, products: []));

        final failureOrSuggestedProducts = await getProductsUseCase(ProductFetchType.byCategory,null,event.id,null,null);
        failureOrSuggestedProducts.fold(
                (suggestedOrFailure) => emit(state.copyWith(
              messages: mapFailureToMessage(suggestedOrFailure),
              productsStatus: ProductsStatus.error,
            )),
                (products) => emit(state.copyWith(
                productsStatus: ProductsStatus.success, products: products)));
      }

      ///Get Product Sort Type
      if (event is GetProductSortTypeEvent) {
        emit(state.copyWith(productsStatus: ProductsStatus.loading, products: state.products));

        final failureOrSuggestedProducts = await getProductsUseCase(ProductFetchType.byCategory,null,event.id,null,event.type);
        failureOrSuggestedProducts.fold(
                (suggestedOrFailure) => emit(state.copyWith(
              messages: mapFailureToMessage(suggestedOrFailure),
              productsStatus: ProductsStatus.error,
            )),
                (products) {
                  print("productsss $products");
                  emit(state.copyWith(
                      productsStatus: ProductsStatus.success, products: products));
                }

        );
      }

    });
  }
}
