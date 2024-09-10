import 'package:equatable/equatable.dart';

import '../models/Invoice Model.dart';


// Events
abstract class CheckoutEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitCheckout extends CheckoutEvent {
  final String name;
  final String address;
  final String pinCode;
  final String mobile;
  final String total;

  SubmitCheckout({required this.name, required this.address, required this.pinCode, required this.mobile, required this.total});

  @override
  List<Object> get props => [name, address, pinCode, mobile];
}

// States
abstract class CheckoutState extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final Invoice invoice;

  CheckoutSuccess(this.invoice);

  @override
  List<Object> get props => [invoice];
}

class CheckoutFailure extends CheckoutState {
  final String error;

  CheckoutFailure(this.error);

  @override
  List<Object> get props => [error];
}
