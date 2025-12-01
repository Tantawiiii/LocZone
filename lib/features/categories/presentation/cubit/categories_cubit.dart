import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loczone/core/api/endpoints.dart';

import '../../../../core/api/api_manager.dart';
import '../../data/category_model.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  bool _isLoading = false;

  Future<void> fetchCategories() async {
    if (_isLoading) return;

    _isLoading = true;

    if (isClosed) return;
    emit(CategoriesLoading());

    try {
      final response = await ApiManager.instance.dio.get(
        EndPoints.getCategories,
      );

      final List data = response.data['data'];

      final categories =
          data.map((json) => CategoryModel.fromJson(json)).toList();

      if (!isClosed) {
        emit(CategoriesLoaded(categories.cast<CategoryModel>()));
      }
    } catch (e) {
      if (!isClosed) {
        emit(CategoriesError('Failed to load categories'));
      }
    } finally {
      _isLoading = false;
    }
  }
}
