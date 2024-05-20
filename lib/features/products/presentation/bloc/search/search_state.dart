part of 'search_bloc.dart';

class SearchState extends Equatable {
  final List<SearchModel> searchValue;
  final List<ProductModel> products;
  final SearchStatus searchStatus;
  final String messages;
  final SearchProductsStatus searchProductsStatus;


  const SearchState(
      {
        this.products = const [],
        this.searchValue = const [],
        this.messages = "",
        this.searchStatus = SearchStatus.loading,
        this.searchProductsStatus = SearchProductsStatus.loading,

      });

  SearchState copyWith({
    List<SearchModel>? searchValue,
    SearchStatus? searchStatus,
    String? messages,
    SearchProductsStatus? searchProductsStatus,
    List<ProductModel>? products,

  }) {
    return SearchState(
      searchValue: searchValue ?? this.searchValue,
      messages: messages ?? this.messages,
      searchStatus: searchStatus ?? this.searchStatus,
      searchProductsStatus: searchProductsStatus ?? this.searchProductsStatus,
      products: products ?? this.products,

    );
  }

  @override
  List<Object> get props => [
    searchValue,
    searchStatus,
    messages,
    searchProductsStatus,
    products
  ];
}

enum SearchStatus {loading, success, error}
enum SearchProductsStatus {loading, success, error}

