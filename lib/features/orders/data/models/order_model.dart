import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/order_entity.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'user_id')
  final String? userId;
  final List<OrderItem>? items;
  @JsonKey(name: 'total_amount')
  final double? totalAmount;
  final OrderStatus? status;
  @JsonKey(name: 'pickup_otp')
  final String? pickupOtp;
  @JsonKey(name: 'delivery_otp')
  final String? deliveryOtp;
  @JsonKey(name: 'pickup_time')
  final DateTime? pickupTime;
  @JsonKey(name: 'delivery_time')
  final DateTime? deliveryTime;
  @JsonKey(name: 'address_id')
  final String? addressId;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  OrderModel({
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

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  // Mapping to domain entity
  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      userId: userId,
      items: items?.map((item) => item.toEntity()).toList(),
      totalAmount: totalAmount,
      status: status,
      pickupOtp: pickupOtp,
      deliveryOtp: deliveryOtp,
      pickupTime: pickupTime,
      deliveryTime: deliveryTime,
      addressId: addressId,
      createdAt: createdAt,
    );
  }

  // Mapping from domain entity
  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      userId: entity.userId,
      items: entity.items?.map((item) => OrderItem.fromEntity(item)).toList(),
      totalAmount: entity.totalAmount,
      status: entity.status,
      pickupOtp: entity.pickupOtp,
      deliveryOtp: entity.deliveryOtp,
      pickupTime: entity.pickupTime,
      deliveryTime: entity.deliveryTime,
      addressId: entity.addressId,
      createdAt: entity.createdAt,
    );
  }
}

@JsonSerializable()
class OrderItem {
  @JsonKey(name: 'service_id')
  final String? serviceId;
  @JsonKey(name: 'service_name')
  final String? serviceName;
  final int? quantity;
  final double? price;

  OrderItem({this.serviceId, this.serviceName, this.quantity, this.price});

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  // Mapping to domain entity
  OrderItemEntity toEntity() {
    return OrderItemEntity(
      serviceId: serviceId,
      serviceName: serviceName,
      quantity: quantity,
      price: price,
    );
  }

  // Mapping from domain entity
  factory OrderItem.fromEntity(OrderItemEntity entity) {
    return OrderItem(
      serviceId: entity.serviceId,
      serviceName: entity.serviceName,
      quantity: entity.quantity,
      price: entity.price,
    );
  }
}
