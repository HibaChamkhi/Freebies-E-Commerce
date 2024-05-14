part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetAllProductsEvent extends ProductEvent {
  const GetAllProductsEvent();

  @override
  List<Object?> get props => [];
}

class GetProductsWithSpecialOffersEvent extends ProductEvent {
  const GetProductsWithSpecialOffersEvent();

  @override
  List<Object?> get props => [];
}

class GetNewProductsEvent extends ProductEvent {
  const GetNewProductsEvent();

  @override
  List<Object?> get props => [];
}

class GetBestSellersEvent extends ProductEvent {
  const GetBestSellersEvent();

  @override
  List<Object?> get props => [];
}

class GetTopRatedProductsEvent extends ProductEvent {
  const GetTopRatedProductsEvent();

  @override
  List<Object?> get props => [];
}

class SearchProductEvent extends ProductEvent {
  final String query ;
  const SearchProductEvent({required this.query,});

  @override
  List<Object?> get props => [query];
}

class GetAllCategoriesEvent extends ProductEvent {
  const GetAllCategoriesEvent();

  @override
  List<Object?> get props => [];
}
