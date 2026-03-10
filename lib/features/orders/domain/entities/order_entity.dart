import 'package:equatable/equatable.dart';

enum OrderStatus {
  pending,
  confirmed,
  pickedUp,
  inProgress,
  outForDelivery,
  delivered,
  cancelled,
  processing,
  completed,
}

class OrderEntity extends Equatable {
  final String? id;
  final String? userId;
  final List<OrderItemEntity>? items;
  final double? totalAmount;
  final OrderStatus? status;
  final String? pickupOtp;
  final String? deliveryOtp;
  final DateTime? pickupTime;
  final DateTime? deliveryTime;
  final String? addressId;
  final DateTime? createdAt;

  const OrderEntity({
    this.id,
    this.userId,
    this.items,
    this.totalAmount,
    this.status,
    this.pickupOtp,
    this.deliveryOtp,
    this.pickupTime,
    this.deliveryTime,
    this.addressId,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        items,
        totalAmount,
        status,
        pickupOtp,
        deliveryOtp,
        pickupTime,
        deliveryTime,
        addressId,
        createdAt,
      ];
}

class OrderItemEntity extends Equatable {
  final String? serviceId;
  final String? serviceName;
  final int? quantity;
  final double? price;

  const OrderItemEntity({
    this.serviceId,
    this.serviceName,
    this.quantity,
    this.price,
  });

  @override
  List<Object?> get props => [serviceId, serviceName, quantity, price];
}
