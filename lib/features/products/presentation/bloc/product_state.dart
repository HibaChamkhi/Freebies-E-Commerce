part of 'product_bloc.dart';


class ProductState extends Equatable {
  final List<ProductModel> products;
  final List<ProductModel> newProducts;
  final List<ProductModel> productsWithSpecialOffers;
  final List<ProductModel> bestSellers;
  final List<ProductModel> topRatedProducts;
  final List<CategoryModel> categories;
  final ProductsStatus productsStatus;
  final CategoriesStatus categoriesStatus;
  final String messages;

  const ProductState(
      {
        this.products = const [],
        this.newProducts = const [],
        this.bestSellers = const [],
        this.topRatedProducts = const [],
        this.productsWithSpecialOffers = const [],
        this.categories = const [],
        this.messages = "",
        this.productsStatus = ProductsStatus.loading,
        this.categoriesStatus = CategoriesStatus.loading,
      });

  ProductState copyWith({
    List<ProductModel>? products,
    List<ProductModel>? productsWithSpecialOffers,
    List<ProductModel>? newProducts,
    List<ProductModel>? bestSellers,
    List<ProductModel>? topRatedProducts,
    List<CategoryModel>? categories,
   ProductsStatus? productsStatus,
    CategoriesStatus? categoriesStatus,
   String? messages,
  }) {
    return ProductState(
      products: products ?? this.products,
      topRatedProducts: topRatedProducts ?? this.topRatedProducts,
      bestSellers: bestSellers ?? this.bestSellers,
      productsWithSpecialOffers: productsWithSpecialOffers ?? this.productsWithSpecialOffers,
      newProducts: newProducts ?? this.newProducts,
      categories: categories ?? this.categories,
      messages: messages ?? this.messages,
      productsStatus: productsStatus ?? this.productsStatus,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
    );
  }

  @override
  List<Object> get props => [
    productsStatus,
    topRatedProducts,
    bestSellers,
    newProducts,
    categories,
    messages,
    categoriesStatus,
    productsWithSpecialOffers,
    products
  ];
}

enum ProductsStatus {loading, success, error}
enum CategoriesStatus {loading, success, error}
