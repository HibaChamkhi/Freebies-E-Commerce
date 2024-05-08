part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetAllProductsEvent extends ProductEvent {
  const GetAllProductsEvent();

  @override
  List<Object?> get props => [];
}
