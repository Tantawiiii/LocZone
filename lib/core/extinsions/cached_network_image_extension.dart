import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum ImageShape { rectangle, rounded, circle }

extension CachedImageExtension on String {
  Widget toCachedImage({
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    Widget? errorWidget,
  }) {
    return _buildCachedImage(
      width: width,
      height: height,
      fit: fit,
      borderRadius: borderRadius,
      errorWidget: errorWidget,
    );
  }

  Widget toCachedImageWithShape({
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    ImageShape shape = ImageShape.rectangle,
    double radius = 8.0,
    Widget? errorWidget,
  }) {
    BorderRadius? borderRadius;

    switch (shape) {
      case ImageShape.circle:
        final size = width ?? height ?? 100;
        return _buildCachedImage(
          width: size,
          height: size,
          fit: fit,
          borderRadius: BorderRadius.circular(size / 2),
          errorWidget: errorWidget,
        );

      case ImageShape.rounded:
        borderRadius = BorderRadius.circular(radius);
        break;

      case ImageShape.rectangle:
        borderRadius = null;
        break;
    }

    return _buildCachedImage(
      width: width,
      height: height,
      fit: fit,
      borderRadius: borderRadius,
      errorWidget: errorWidget,
    );
  }

  Widget _buildCachedImage({
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    Widget? errorWidget,
  }) {
    final image = CachedNetworkImage(
      imageUrl: this,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, __) => _buildShimmer(width, height),
      errorWidget:
          (_, __, ___) =>
              errorWidget ?? const Icon(Icons.broken_image, size: 48),
    );

    return borderRadius != null
        ? ClipRRect(borderRadius: borderRadius, child: image)
        : image;
  }

  Widget _buildShimmer(double? width, double? height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 200,
        color: Colors.white,
      ),
    );
  }
}
