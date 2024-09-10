// In product_block.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../Data/api_service.dart';
import '../models/product_model.dart';

// Events
abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {}

// States
abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  final String error;

  ProductError(this.error);

  @override
  List<Object> get props => [error];
}

// Bloc
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiService apiService;

  ProductBloc(this.apiService) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  void _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await apiService.fetchProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
