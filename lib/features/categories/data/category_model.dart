class CategoryModel {
  final int id;
  final String name;
  final String imagePath;
  final String details;
  final int productCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.details,
    required this.productCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      imagePath: json['imagePath'],
      details: json['details'],
      productCount: json['productCount'],
    );
  }
}
