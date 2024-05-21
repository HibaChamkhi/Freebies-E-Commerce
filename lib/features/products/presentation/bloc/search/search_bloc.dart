import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freebies_e_commerce/features/products/data/models/search/search.dart';
import 'package:freebies_e_commerce/features/products/domain/use_cases/get_search_value_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/extensions/map_failure_to_message.dart';
import '../../../data/data_source/supabase_data_source.dart';
import '../../../data/models/product/product.dart';
import '../../../domain/use_cases/delete_search_value_use_case.dart';
import '../../../domain/use_cases/get_products_use_case.dart';
import '../../../domain/use_cases/set_search_value_use_case.dart';

part 'search_event.dart';

part 'search_state.dart';
@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchValueUseCase getSearchValueUseCase;
  final DeleteSearchValueUseCase deleteSearchValueUseCase;
  final SetSearchValueUseCase setSearchValueUseCase;
  final GetProductsUseCase getProductsUseCase;


  SearchBloc({
    required this.getSearchValueUseCase,
    required this.getProductsUseCase,
    required this.deleteSearchValueUseCase,
    required this.setSearchValueUseCase,
  }) : super(const SearchState()) {
    on<SearchEvent>((event, emit) async {
      ///search
      if (event is SearchProductEvent) {
        emit(state.copyWith(searchProductsStatus: SearchProductsStatus.loading, products: []));

        final failureOrSuggestedProducts = await getProductsUseCase(ProductFetchType.all,event.query,null,null,null,null,null);
        failureOrSuggestedProducts.fold(
                (suggestedOrFailure) => emit(state.copyWith(
              messages: mapFailureToMessage(suggestedOrFailure),
                  searchProductsStatus: SearchProductsStatus.error,
            )),
                (products)
            {
              print(products);
              emit(state.copyWith(
                  searchProductsStatus: SearchProductsStatus.success,
                  products: products));
            });
      }
      ///Get Search Value Event
      if (event is GetSearchValueEvent) {
        emit(state
            .copyWith(searchStatus: SearchStatus.loading, searchValue: []));

        final failureOrSuggestedProducts = await getSearchValueUseCase();
        failureOrSuggestedProducts.fold(
            (suggestedOrFailure) => emit(state.copyWith(
                  messages: mapFailureToMessage(suggestedOrFailure),
                  searchStatus: SearchStatus.error,
                )),
            (searchValue) => emit(state.copyWith(
                searchStatus: SearchStatus.success, searchValue: searchValue)));
      }
      ///Delete Search Value Event
      if (event is DeleteSearchValueEvent) {
        emit(state.copyWith(searchStatus: SearchStatus.loading));

        final failureOrSuggestedProducts =
            await deleteSearchValueUseCase(event.id);
        failureOrSuggestedProducts.fold(
            (suggestedOrFailure) => emit(state.copyWith(
                  messages: mapFailureToMessage(suggestedOrFailure),
                  searchStatus: SearchStatus.error,
                )),
            (searchValue) =>
                emit(state.copyWith(searchStatus: SearchStatus.success ,
                searchValue: state.searchValue
                    .where((e) => e.id != event.id)
                    .toList()
                )));
      }
      ///Set Search Value Event
      if (event is SetSearchValueEvent) {
        emit(state.copyWith(searchStatus: SearchStatus.loading));

        final failureOrSuggestedProducts =
            await setSearchValueUseCase(event.searchValue);
        failureOrSuggestedProducts.fold(
            (suggestedOrFailure) => emit(state.copyWith(
                  messages: mapFailureToMessage(suggestedOrFailure),
                  searchStatus: SearchStatus.error,
                )),
            (searchValue) =>
                emit(state.copyWith(searchStatus: SearchStatus.success)));
      }
    });
  }
}
