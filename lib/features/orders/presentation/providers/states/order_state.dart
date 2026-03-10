import 'package:flutter/foundation.dart';
import '../../../domain/entities/order_entity.dart';
import '../../../data/models/tracking_model.dart';

abstract class OrderState {
  const OrderState();
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderLoading extends OrderState {
  const OrderLoading();
}

class OrderSuccess extends OrderState {
  final List<OrderEntity> activeOrders;
  final List<OrderEntity> pastOrders;
  final OrderEntity? currentOrder;
  final TrackingModel? currentTracking;

  const OrderSuccess({
    this.activeOrders = const [],
    this.pastOrders = const [],
    this.currentOrder,
    this.currentTracking,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderSuccess &&
          runtimeType == other.runtimeType &&
          listEquals(activeOrders, other.activeOrders) &&
          listEquals(pastOrders, other.pastOrders) &&
          currentOrder == other.currentOrder &&
          currentTracking == other.currentTracking;

  @override
  int get hashCode =>
      Object.hash(activeOrders, pastOrders, currentOrder, currentTracking);
}

class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
