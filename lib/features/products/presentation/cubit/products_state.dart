import '../../data/product_model.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final bool hasNext;

  ProductsLoaded({
    required this.products,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.hasNext,
  });
}

class ProductsError extends ProductsState {
  final String message;

  ProductsError(this.message);
}

class ProductsEmpty extends ProductsState {}
