import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loczone/core/extinsions/cached_network_image_extension.dart';
import 'package:loczone/core/utils/app_colors.dart';
import 'package:loczone/core/utils/app_strings.dart';
import 'package:loczone/core/utils/app_text_styles.dart';
import '../../data/category_model.dart';
import '../../../products/presentation/screens/products_screen.dart';
import '../../../products/presentation/cubit/products_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Bounce(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => BlocProvider(
                    create: (context) => ProductsCubit(),
                    child: ProductsScreen(
                      categoryId: category.id,
                      categoryName: category.name,
                    ),
                  ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  category.imagePath.toCachedImageWithShape(
                    shape: ImageShape.circle,
                    width: 64,
                    height: 64,
                  ),
                  12.horizontalSpace,
                  Column(
                    children: [
                      Text(category.name, style: AppTextStyles.headingSmall),
                      Text(
                        '+${category.productCount} ${AppStrings.products}',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ],
              ),

              Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
