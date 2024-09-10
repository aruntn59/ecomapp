// product_model.dart
class Product {
  final String title;
  final String thumbnail;
  final double price;

  Product({
    required this.title,
    required this.thumbnail,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      price: (json['price'] as num).toDouble(), // Use num to handle int and double values
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'thumbnail': thumbnail,
      'price': price,
    };
  }
}
