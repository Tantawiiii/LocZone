import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loczone/core/api/endpoints.dart';
import 'package:loczone/core/api/api_manager.dart';
import '../../data/product_model.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  bool _isLoading = false;
  int _currentPage = 1;
  List<ProductModel> _allProducts = [];

  Future<void> fetchProductsByCategory({
    int? categoryId,
    String? vendorIds,
    String? typeIds,
    int? minPrice,
    int? maxPrice,
    String? sizeIds,
    String? colorIds,
    bool refresh = false,
  }) async {
    if (_isLoading) return;

    _isLoading = true;

    if (refresh) {
      _currentPage = 1;
      _allProducts.clear();
    }

    if (isClosed) return;
    emit(ProductsLoading());

    try {
      // Build query parameters
      final Map<String, dynamic> queryParams = {};
      if (categoryId != null) queryParams['CategoryId'] = categoryId;
      if (vendorIds != null) queryParams['VendorIds'] = vendorIds;
      if (typeIds != null) queryParams['TypeIds'] = typeIds;
      if (minPrice != null) queryParams['MinPrice'] = minPrice;
      if (maxPrice != null) queryParams['MaxPrice'] = maxPrice;
      if (sizeIds != null) queryParams['SizeIds'] = sizeIds;
      if (colorIds != null) queryParams['ColorIds'] = colorIds;

      final response = await ApiManager.instance.dio.get(
        EndPoints.getProducts,
        queryParameters: queryParams,
      );

      final data = response.data['data'];
      final List pageData = data['page'] ?? [];
      final int currentPage = data['currentPage'] ?? 1;
      final int totalPages = data['totalPages'] ?? 1;
      final int totalCount = data['totalCount'] ?? 0;
      final bool hasNext = data['hasNext'] ?? false;

      final newProducts =
          pageData
              .map((json) => ProductModel.fromJson(json))
              .toList()
              .cast<ProductModel>();

      if (refresh) {
        _allProducts = newProducts;
      } else {
        _allProducts.addAll(newProducts);
      }

      _currentPage = currentPage;

      if (!isClosed) {
        if (_allProducts.isEmpty) {
          emit(ProductsEmpty());
        } else {
          emit(
            ProductsLoaded(
              products: _allProducts,
              currentPage: currentPage,
              totalPages: totalPages,
              totalCount: totalCount,
              hasNext: hasNext,
            ),
          );
        }
      }
    } catch (e) {
      if (!isClosed) {
        emit(ProductsError('Failed to load products: ${e.toString()}'));
      }
    } finally {
      _isLoading = false;
    }
  }

  Future<void> loadMoreProducts({
    int? categoryId,
    String? vendorIds,
    String? typeIds,
    int? minPrice,
    int? maxPrice,
    String? sizeIds,
    String? colorIds,
  }) async {
    if (_isLoading || !_hasMorePages()) return;

    _currentPage++;

    await fetchProductsByCategory(
      categoryId: categoryId,
      vendorIds: vendorIds,
      typeIds: typeIds,
      minPrice: minPrice,
      maxPrice: maxPrice,
      sizeIds: sizeIds,
      colorIds: colorIds,
    );
  }

  bool _hasMorePages() {
    if (state is ProductsLoaded) {
      final currentState = state as ProductsLoaded;
      return currentState.hasNext;
    }
    return false;
  }

  void resetProducts() {
    _currentPage = 1;
    _allProducts.clear();
    emit(ProductsInitial());
  }

  bool get isLoading => _isLoading;

  int get currentPage => _currentPage;

  List<ProductModel> get allProducts => List.unmodifiable(_allProducts);
}
