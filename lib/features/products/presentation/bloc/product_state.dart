part of 'product_bloc.dart';


class ProductState extends Equatable {
  final List<ProductModel> products;
  final ProductsStatus productsStatus;
  final String messages;

  const ProductState(
      {this.products = const [],
        this.messages = "",
        this.productsStatus = ProductsStatus.loading});

  ProductState copyWith({
    List<ProductModel>? products,
   ProductsStatus? productsStatus,
   String? messages,
  }) {
    return ProductState(
      products: products ?? this.products,
      messages: messages ?? this.messages,
      productsStatus: productsStatus ?? this.productsStatus,
    );
  }

  @override
  List<Object> get props => [
    productsStatus,
    messages,
    products
  ];
}

enum ProductsStatus {loading, success, error}
