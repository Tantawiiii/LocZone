import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loczone/core/utils/app_strings.dart';

import '../cubit/categories_cubit.dart';
import '../cubit/categories_state.dart';
import '../widgets/category_card.dart';
import '../widgets/shimmer_category_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoriesCubit()..fetchCategories(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.categories),
          centerTitle: true,
        ),
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoading) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 6,
                itemBuilder: (context, index) => const ShimmerCategoryCard(),
              );
            } else if (state is CategoriesLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return CategoryCard(category: category);
                },
              );
            } else if (state is CategoriesError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
