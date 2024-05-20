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

class GetProductsByCategoryEvent extends ProductEvent {
  final String id;
  const GetProductsByCategoryEvent({required this.id});

  @override
  List<Object?> get props => [];
}

class GetProductSortTypeEvent extends ProductEvent {
  final ProductSortType type;
  final String id;
  const GetProductSortTypeEvent( {required this.id,required this.type});

  @override
  List<Object?> get props => [id,type];
}

class SearchProductByCategoryEvent extends ProductEvent {
  final String query ;
  final String id ;
  const SearchProductByCategoryEvent({required this.query,required this.id,});

  @override
  List<Object?> get props => [query,id];
}

class GetAllCategoriesEvent extends ProductEvent {
  const GetAllCategoriesEvent();

  @override
  List<Object?> get props => [];
}
