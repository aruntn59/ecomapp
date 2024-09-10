import 'package:dio/dio.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class ApiService {
  final Dio _dio = Dio();
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get('https://dummyjson.com/products');
      return (response.data['products'] as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<Cart?> fetchCart() async {
    try {
      final response = await _dio.get('https://dummyjson.com/cart');
      return Cart.fromJson(response.data);
    } catch (e) {
      print('Error fetching cart: $e');
      return null;  // or return an empty Cart() if you have a default constructor
    }
  }


// Future<List<Product>> fetchProducts() async {
  //   final response = await _dio.get('https://dummyjson.com/products');
  //   return (response.data['products'] as List)
  //       .map((json) => Product.fromJson(json))
  //       .toList();
  // }
  //
  // Future<Cart> fetchCart() async {
  //   // This can be removed if we're not fetching the cart from the server.
  //   final response = await _dio.get('https://dummyjson.com/cart');
  //   return Cart.fromJson(response.data);
  // }
}
