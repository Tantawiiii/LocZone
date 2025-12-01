import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loczone/core/extinsions/cached_network_image_extension.dart';
import 'package:loczone/core/utils/app_colors.dart';
import 'package:loczone/core/utils/app_text_styles.dart';
import '../../data/product_model.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavoriteToggle,
    this.onAddToCart,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(6.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 1,
      color: AppColors.white,
      child: Bounce(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.r),
                  ),
                  child: Container(
                    height: 140.h,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: widget.product.imageUrls.length,
                      itemBuilder: (context, index) {
                        return widget.product.imageUrls[index]
                            .toCachedImageWithShape(
                              width: double.infinity,
                              height: 140.h,
                              fit: BoxFit.cover,
                              shape: ImageShape.rectangle,
                            );
                      },
                    ),
                  ),
                ),

                Positioned(
                  bottom: 4.h,
                  right: 8.w,
                  left: 8.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Page Indicators
                      GestureDetector(
                        onTap: widget.onAddToCart,
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.shopping_bag_rounded,
                            color: Colors.grey,
                            size: 18.w,
                          ),
                        ),
                      ),
                      if (widget.product.imageUrls.length > 1)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            widget.product.imageUrls.length,
                            (index) => Container(
                              width: 6.w,
                              height: 6.h,
                              margin: EdgeInsets.only(right: 4.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    _currentPage == index
                                        ? AppColors.primaryColor
                                        : Colors.white.withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                        ),

                      // Cart Icon
                    ],
                  ),
                ),

                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: widget.onFavoriteToggle,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.product.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                            widget.product.isFavourite
                                ? Colors.red
                                : Colors.grey.shade200,
                        size: 24.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        widget.product.name,
                        maxLines: 1,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.darkBlack,
                        ),
                      ),
                    ),
                    4.verticalSpace,
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              'EGP ${widget.product.finalPrice.toStringAsFixed(0)}',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.darkBlack,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (widget.product.hasDiscount) ...[
                            SizedBox(width: 4.w),
                            Flexible(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'EGP ${widget.product.price.toStringAsFixed(0)}',
                                      style: AppTextStyles.caption.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: Text(
                                      '${widget.product.discountPerc.toStringAsFixed(0)}%',
                                      style: AppTextStyles.caption.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    4.verticalSpace,
                    Flexible(
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16.w),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              '${widget.product.rate} (${widget.product.ratingCount}+)',
                              style: AppTextStyles.caption.copyWith(
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
