// cart_state.dart
import '../models/product_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<Product> cart;

  CartLoaded(this.cart);
}

class CartFailure extends CartState {
  final String error;

  CartFailure(this.error);
}
