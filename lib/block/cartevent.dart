// cart_event.dart
import '../models/product_model.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;

  AddToCart(this.product);
}
