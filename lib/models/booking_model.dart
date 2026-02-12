class BookingModel {
  final String? id;
  final String? userId;
  final List<BookingItem>? items;
  final double? subtotal;
  final double? discount;
  final double? deliveryCharge;
  final double? totalAmount;
  final String? addressId;
  final DateTime? pickupDate;
  final String? pickupSlot;
  final DateTime? deliveryDate;
  final String? deliverySlot;
  final String? paymentMethod;
  final String? couponCode;

  BookingModel({
    this.id,
    this.userId,
    this.items,
    this.subtotal,
    this.discount,
    this.deliveryCharge,
    this.totalAmount,
    this.addressId,
    this.pickupDate,
    this.pickupSlot,
    this.deliveryDate,
    this.deliverySlot,
    this.paymentMethod,
    this.couponCode,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      userId: json['user_id'],
      items: json['items'] != null
          ? (json['items'] as List).map((e) => BookingItem.fromJson(e)).toList()
          : null,
      subtotal: json['subtotal']?.toDouble(),
      discount: json['discount']?.toDouble(),
      deliveryCharge: json['delivery_charge']?.toDouble(),
      totalAmount: json['total_amount']?.toDouble(),
      addressId: json['address_id'],
      pickupDate: json['pickup_date'] != null
          ? DateTime.parse(json['pickup_date'])
          : null,
      pickupSlot: json['pickup_slot'],
      deliveryDate: json['delivery_date'] != null
          ? DateTime.parse(json['delivery_date'])
          : null,
      deliverySlot: json['delivery_slot'],
      paymentMethod: json['payment_method'],
      couponCode: json['coupon_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'items': items?.map((e) => e.toJson()).toList(),
      'subtotal': subtotal,
      'discount': discount,
      'delivery_charge': deliveryCharge,
      'total_amount': totalAmount,
      'address_id': addressId,
      'pickup_date': pickupDate?.toIso8601String(),
      'pickup_slot': pickupSlot,
      'delivery_date': deliveryDate?.toIso8601String(),
      'delivery_slot': deliverySlot,
      'payment_method': paymentMethod,
      'coupon_code': couponCode,
    };
  }
}

class BookingItem {
  final String? serviceId;
  final String? serviceName;
  final int quantity;
  final double? pricePerUnit;
  final double? totalPrice;

  BookingItem({
    this.serviceId,
    this.serviceName,
    this.quantity = 1,
    this.pricePerUnit,
    this.totalPrice,
  });

  factory BookingItem.fromJson(Map<String, dynamic> json) {
    return BookingItem(
      serviceId: json['service_id'],
      serviceName: json['service_name'],
      quantity: json['quantity'] ?? 1,
      pricePerUnit: json['price_per_unit']?.toDouble(),
      totalPrice: json['total_price']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'service_name': serviceName,
      'quantity': quantity,
      'price_per_unit': pricePerUnit,
      'total_price': totalPrice,
    };
  }
}
