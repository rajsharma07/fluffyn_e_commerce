class Rating {
  double rate;
  int count;
  Rating(this.rate, this.count);
  factory Rating.fromJson(Map<String, dynamic> r) {
    return Rating(r['rate'].toDouble(), r['count']);
  }
}

class ProductsModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;
  const ProductsModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
        id: json['id'] ?? 0,
        title: json['title'] ?? "",
        price: json['price'].toDouble() ?? 0.0,
        description: json['description'] ?? "",
        category: json['category'] ?? "",
        image: json['image'] ?? "",
        rating: Rating.fromJson(json['rating']));
  }
}
