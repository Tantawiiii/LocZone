import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:loczone/core/utils/app_colors.dart';
import 'package:loczone/core/utils/app_strings.dart';
import 'package:loczone/core/utils/app_text_styles.dart';
import '../../../../core/widgets/address_header_widget.dart';
import '../cubit/products_cubit.dart';
import '../cubit/products_state.dart';
import '../widgets/product_card.dart';
import '../widgets/filter_container_widget.dart';

class ProductsScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const ProductsScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  Timer? _debounceTimer;
  bool _isFilterActive = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsCubit>().fetchProductsByCategory(
        categoryId: widget.categoryId,
        refresh: true,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ProductsCubit>().loadMoreProducts(
        categoryId: widget.categoryId,
      );
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        context.read<ProductsCubit>().fetchProductsByCategory(
          categoryId: widget.categoryId,
          refresh: true,
        );
      } else {
        setState(() {});
      }
    });
  }

  List<dynamic> _getFilteredProducts(ProductsLoaded state) {
    if (_searchQuery.isEmpty) {
      return state.products;
    }

    return state.products.where((product) {
      final productName = product.name.toLowerCase();
      final productColor = product.colorName.toLowerCase();
      final productVendor = product.vendorName.toLowerCase();
      final query = _searchQuery.toLowerCase();

      return productName.contains(query) ||
          productColor.contains(query) ||
          productVendor.contains(query);
    }).toList();
  }

  void _onFilterPressed() {
    setState(() {
      _isFilterActive = !_isFilterActive;
    });

    // TODO: Implement filter functionality
    // You can show a filter bottom sheet or navigate to filter screen
    // For now, we'll just toggle the visual state

    if (_isFilterActive) {
      // Show filter options or navigate to filter screen
      // You can implement your filter logic here
      _showFilterOptions();
    } else {
      // Clear filters and reset to default state
      // You can implement filter clearing logic here
      _clearFilters();
    }
  }

  void _showFilterOptions() {
    // TODO: Show filter bottom sheet or navigate to filter screen
    // This is where you would implement the actual filter UI
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Filter options will be implemented here'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      _isFilterActive = false;
    });

    // TODO: Clear any applied filters and reset to default state
    // This is where you would reset filter values

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Filters cleared'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading && state is! ProductsLoaded) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (state is ProductsError) {
            print(state.message);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: AppTextStyles.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is ProductsEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No products found',
                    style: AppTextStyles.headingSmall.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is ProductsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProductsCubit>().fetchProductsByCategory(
                  categoryId: widget.categoryId,
                  refresh: true,
                );
              },
              child: Stack(
                children: [
                  Column(
                    children: [
                      DeliveryHeaderWidget(
                        address: "Tayaran Street, Madenit Nasr",
                        onBack: () => Navigator.pop(context),
                        onCart: () {},
                        onSearchChanged: _onSearchChanged,
                      ),

                      if (_searchQuery.isNotEmpty &&
                          _getFilteredProducts(state).isEmpty)
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No products found for "$_searchQuery"',
                                  style: AppTextStyles.headingSmall.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Try adjusting your search terms',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: Colors.grey[500],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: GridView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.75,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                            itemCount:
                                _getFilteredProducts(state).length +
                                (state.hasNext ? 1 : 0),
                            itemBuilder: (context, index) {
                              final filteredProducts = _getFilteredProducts(
                                state,
                              );

                              if (index == filteredProducts.length) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                );
                              }

                              final product = filteredProducts[index];
                              return ProductCard(
                                product: product,
                                onTap: () {},
                                onFavoriteToggle: () {},
                                onAddToCart: () {},
                              );
                            },
                          ),
                        ),
                    ],
                  ),

                  //
                  Positioned(
                    bottom: 40.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: FilterContainerWidget(
                        onFilterPressed: _onFilterPressed,
                        isActive: _isFilterActive,
                        filterCount: _isFilterActive ? "1" : null,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
