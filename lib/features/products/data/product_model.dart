class ProductModel {
  final int id;
  final String name;
  final double price;
  final double discountPerc;
  final double discountPrice;
  final List<String> imageUrls;
  final double rate;
  final int quantity;
  final int ratingCount;
  final bool isFavourite;
  final String colorName;
  final int typeId;
  final int vendorId;
  final String vendorName;
  final int colorId;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.discountPerc,
    required this.discountPrice,
    required this.imageUrls,
    required this.rate,
    required this.quantity,
    required this.ratingCount,
    required this.isFavourite,
    required this.colorName,
    required this.typeId,
    required this.vendorId,
    required this.vendorName,
    required this.colorId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: _parseToDouble(json['price']),
      discountPerc: _parseToDouble(json['discountPerc']),
      discountPrice: _parseToDouble(json['discountPrice']),
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      rate: _parseToDouble(json['rate']),
      quantity: json['quantity'] ?? 0,
      ratingCount: json['ratingCount'] ?? 0,
      isFavourite: json['isFavourite'] ?? false,
      colorName: json['colorName'] ?? '',
      typeId: json['typeId'] ?? 0,
      vendorId: json['vendorId'] ?? 0,
      vendorName: json['vendorName'] ?? '',
      colorId: json['colorId'] ?? 0,
    );
  }

  static double _parseToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        return 0.0;
      }
    }
    return 0.0;
  }

  double get finalPrice => discountPerc > 0 ? price - discountPrice : price;
  bool get hasDiscount => discountPerc > 0;
  String get firstImage => imageUrls.isNotEmpty ? imageUrls.first : '';
}
