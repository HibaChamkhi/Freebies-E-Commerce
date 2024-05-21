part of 'product_bloc.dart';


class ProductState extends Equatable {
  final List<ProductModel> products;
  final List<ProductModel> newProducts;
  final List<ProductModel> productsWithSpecialOffers;
  final List<ProductModel> bestSellers;
  final List<ProductModel> topRatedProducts;
  final List<CategoryModel> categories;
  final List<SubCategoryModel> subCategories;
  final ProductsStatus productsStatus;
  final SearchProductsByCategoryStatus searchProductsByCategoryStatus;
  final CategoriesStatus categoriesStatus;
  final SubCategoriesStatus subCategoriesStatus;
  final String messages;

  const ProductState(
      {
        this.products = const [],
        this.newProducts = const [],
        this.bestSellers = const [],
        this.topRatedProducts = const [],
        this.productsWithSpecialOffers = const [],
        this.categories = const [],
        this.subCategories = const [],
        this.messages = "",
        this.productsStatus = ProductsStatus.loading,
        this.searchProductsByCategoryStatus = SearchProductsByCategoryStatus.loading,
        this.categoriesStatus = CategoriesStatus.loading,
        this.subCategoriesStatus = SubCategoriesStatus.loading,
      });

  ProductState copyWith({
    List<ProductModel>? products,
    List<ProductModel>? productsWithSpecialOffers,
    List<ProductModel>? newProducts,
    List<ProductModel>? bestSellers,
    List<ProductModel>? topRatedProducts,
    List<CategoryModel>? categories,
    List<SubCategoryModel>? subCategories,
   ProductsStatus? productsStatus,
    SearchProductsByCategoryStatus? searchProductsByCategoryStatus,
    CategoriesStatus? categoriesStatus,
    SubCategoriesStatus? subCategoriesStatus,
   String? messages,
  }) {
    return ProductState(
      products: products ?? this.products,
      topRatedProducts: topRatedProducts ?? this.topRatedProducts,
      bestSellers: bestSellers ?? this.bestSellers,
      productsWithSpecialOffers: productsWithSpecialOffers ?? this.productsWithSpecialOffers,
      newProducts: newProducts ?? this.newProducts,
      categories: categories ?? this.categories,
      subCategories: subCategories ?? this.subCategories,
      messages: messages ?? this.messages,
      productsStatus: productsStatus ?? this.productsStatus,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      subCategoriesStatus: subCategoriesStatus ?? this.subCategoriesStatus,
      searchProductsByCategoryStatus: searchProductsByCategoryStatus ?? this.searchProductsByCategoryStatus,
    );
  }

  @override
  List<Object> get props => [
    productsStatus,
    topRatedProducts,
    subCategories,
    bestSellers,
    newProducts,
    categories,
    messages,
    subCategoriesStatus,
    categoriesStatus,
    productsWithSpecialOffers,
    searchProductsByCategoryStatus,
    products
  ];
}

enum ProductsStatus {loading, success, error}
enum SearchProductsByCategoryStatus {loading, success, error}
enum CategoriesStatus {loading, success, error}
enum SubCategoriesStatus {loading, success, error}
