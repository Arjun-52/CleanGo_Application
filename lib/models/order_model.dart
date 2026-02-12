enum OrderStatus {
  pending,
  confirmed,
  pickedUp,
  inProgress,
  outForDelivery,
  delivered,
  cancelled,
}

class OrderModel {
  final String? id;
  final String? userId;
  final List<OrderItem>? items;
  final double? totalAmount;
  final OrderStatus? status;
  final String? pickupOtp;
  final String? deliveryOtp;
  final DateTime? pickupTime;
  final DateTime? deliveryTime;
  final String? addressId;
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

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      items: json['items'] != null
          ? (json['items'] as List).map((e) => OrderItem.fromJson(e)).toList()
          : null,
      totalAmount: json['total_amount']?.toDouble(),
      status: json['status'] != null
          ? OrderStatus.values.firstWhere(
              (e) => e.name == json['status'],
              orElse: () => OrderStatus.pending,
            )
          : null,
      pickupOtp: json['pickup_otp'],
      deliveryOtp: json['delivery_otp'],
      pickupTime: json['pickup_time'] != null
          ? DateTime.parse(json['pickup_time'])
          : null,
      deliveryTime: json['delivery_time'] != null
          ? DateTime.parse(json['delivery_time'])
          : null,
      addressId: json['address_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'items': items?.map((e) => e.toJson()).toList(),
      'total_amount': totalAmount,
      'status': status?.name,
      'pickup_otp': pickupOtp,
      'delivery_otp': deliveryOtp,
      'pickup_time': pickupTime?.toIso8601String(),
      'delivery_time': deliveryTime?.toIso8601String(),
      'address_id': addressId,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}

class OrderItem {
  final String? serviceId;
  final String? serviceName;
  final int? quantity;
  final double? price;

  OrderItem({
    this.serviceId,
    this.serviceName,
    this.quantity,
    this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      serviceId: json['service_id'],
      serviceName: json['service_name'],
      quantity: json['quantity'],
      price: json['price']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'service_name': serviceName,
      'quantity': quantity,
      'price': price,
    };
  }
}
