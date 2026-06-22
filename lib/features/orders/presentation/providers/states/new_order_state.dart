import 'package:flutter/foundation.dart';
import '../../../data/models/create_order_model.dart';

abstract class NewOrderState {
  const NewOrderState();
}

class NewOrderInitial extends NewOrderState {
  const NewOrderInitial();
}

class NewOrderLoading extends NewOrderState {
  const NewOrderLoading();
}

class NewOrderSuccess extends NewOrderState {
  final Map<String, int> cart;
  final Set<String> selectedAddons;
  final int selectedMode;
  final int selectedService;
  final int selectedFilter;

  const NewOrderSuccess({
    required this.cart,
    required this.selectedAddons,
    required this.selectedMode,
    required this.selectedService,
    required this.selectedFilter,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewOrderSuccess &&
      runtimeType == other.runtimeType &&
      mapEquals(cart, other.cart) &&
      setEquals(selectedAddons, other.selectedAddons) &&
      selectedMode == other.selectedMode &&
      selectedService == other.selectedService &&
      selectedFilter == other.selectedFilter;

  @override
  int get hashCode => Object.hash(
        cart,
        selectedAddons,
        selectedMode,
        selectedService,
        selectedFilter,
      );
}

class NewOrderError extends NewOrderState {
  final String message;

  const NewOrderError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewOrderError &&
      runtimeType == other.runtimeType &&
      message == other.message;

  @override
  int get hashCode => message.hashCode;
}

class CreateOrderLoading extends NewOrderState {
  const CreateOrderLoading();
}

class CreateOrderSuccess extends NewOrderState {
  final CreateOrderModel order;

  const CreateOrderSuccess(this.order);
}

class CreateOrderError extends NewOrderState {
  final String message;

  const CreateOrderError(this.message);
}
