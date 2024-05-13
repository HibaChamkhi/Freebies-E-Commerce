import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freebies_e_commerce/features/products/data/models/product.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/extensions/map_failure_to_message.dart';
import '../../domain/use_cases/get_products_use_case.dart';

part 'product_event.dart';

part 'product_state.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductBloc({required this.getProductsUseCase})
      : super(const ProductState()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetAllProductsEvent) {
        emit(state.copyWith(productsStatus: ProductsStatus.loading, products: []));

        final failureOrSuggestedProducts = await getProductsUseCase();
        failureOrSuggestedProducts.fold(
            (suggestedPlayersFailure) => emit(state.copyWith(
                  messages: mapFailureToMessage(suggestedPlayersFailure),
                  productsStatus: ProductsStatus.error,
                )),
            (products) => emit(state.copyWith(
                productsStatus: ProductsStatus.success, products: products)));
      }
    });
  }
}
