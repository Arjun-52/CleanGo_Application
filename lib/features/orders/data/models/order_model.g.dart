// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: json['id'] as String?,
  userId: json['user_id'] as String?,
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalAmount: (json['total_amount'] as num?)?.toDouble(),
  status: $enumDecodeNullable(_$OrderStatusEnumMap, json['status']),
  pickupOtp: json['pickup_otp'] as String?,
  deliveryOtp: json['delivery_otp'] as String?,
  pickupTime: json['pickup_time'] == null
      ? null
      : DateTime.parse(json['pickup_time'] as String),
  deliveryTime: json['delivery_time'] == null
      ? null
      : DateTime.parse(json['delivery_time'] as String),
  addressId: json['address_id'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'items': instance.items,
      'total_amount': instance.totalAmount,
      'status': _$OrderStatusEnumMap[instance.status],
      'pickup_otp': instance.pickupOtp,
      'delivery_otp': instance.deliveryOtp,
      'pickup_time': instance.pickupTime?.toIso8601String(),
      'delivery_time': instance.deliveryTime?.toIso8601String(),
      'address_id': instance.addressId,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.confirmed: 'confirmed',
  OrderStatus.pickedUp: 'pickedUp',
  OrderStatus.inProgress: 'inProgress',
  OrderStatus.outForDelivery: 'outForDelivery',
  OrderStatus.delivered: 'delivered',
  OrderStatus.cancelled: 'cancelled',
  OrderStatus.processing: 'processing',
  OrderStatus.completed: 'completed',
};

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
  serviceId: json['service_id'] as String?,
  serviceName: json['service_name'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
  price: (json['price'] as num?)?.toDouble(),
);

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
  'service_id': instance.serviceId,
  'service_name': instance.serviceName,
  'quantity': instance.quantity,
  'price': instance.price,
};
