import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../Data/api_service.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

// Events
abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;

  AddToCart(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final Product product;

  RemoveFromCart(this.product);

  @override
  List<Object> get props => [product];
}

class FetchCart extends CartEvent {}

// States
abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Product> cart;
  final double total;

  CartLoaded(this.cart) : total = cart.fold(0, (sum, item) => sum + item.price);

  @override
  List<Object> get props => [cart, total];
}

class CartError extends CartState {
  final String error;

  CartError(this.error);

  @override
  List<Object> get props => [error];
}

// Bloc
class CartBloc extends Bloc<CartEvent, CartState> {
  List<Product> _cart = [];

  CartBloc() : super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<FetchCart>(_onFetchCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      // Check for duplicate items to avoid adding the same product twice
      if (!_cart.contains(event.product)) {
        _cart.add(event.product);
      }
      emit(CartLoaded(_cart));
    } catch (e) {
      emit(CartError("Failed to add product to cart: ${e.toString()}"));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      // Remove product if it's in the cart
      _cart.remove(event.product);
      emit(CartLoaded(_cart));
    } catch (e) {
      emit(CartError("Failed to remove product from cart: ${e.toString()}"));
    }
  }

  void _onFetchCart(FetchCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      emit(CartLoaded(_cart));
    } catch (e) {
      emit(CartError("Failed to fetch cart: ${e.toString()}"));
    }
  }
}
