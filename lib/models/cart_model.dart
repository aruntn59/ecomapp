import 'package:ecomapp/models/product_model.dart';

class Cart {
  final List<Product> products;
  final double total;

  Cart({required this.products, required this.total});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      products: (json['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
      total: json['total'].toDouble(),
    );
  }
}
