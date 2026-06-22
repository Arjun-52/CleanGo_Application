class OrderTimelineResponse {
  final String status;
  final String message;
  final OrderTimelineModel? data;

  OrderTimelineResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory OrderTimelineResponse.fromJson(Map<String, dynamic> json) {
    return OrderTimelineResponse(
      status: json['status'] as String? ?? 'error',
      message: json['message'] as String? ?? '',
      data: json['data'] != null
          ? OrderTimelineModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class OrderTimelineModel {
  final String? id;
  final String? orderRef;
  final String? customerId;
  final String? customerName;
  final int? itemsCount;
  final String? serviceMode;
  final String? serviceType;
  final String? addons;
  final double? price;
  final String? status;
  final String? slaStatus;
  final DateTime? slaDeadline;
  final String? storeId;
  final String? assignedFleetId;
  final String? pickupOtp;
  final String? deliveryOtp;
  final String? packetQr;
  final String? pickupSlot;
  final String? deliverySlot;
  final DateTime? pickupTime;
  final DateTime? deliveryTime;
  final List<dynamic>? qcChecklist;
  final List<dynamic>? damageTags;
  final bool? isSubscription;
  final String? parentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  // Timeline Collections
  final List<dynamic>? handoffEvents;
  final List<QrEventModel>? qrEvents;
  final List<dynamic>? otpEvents;
  final List<dynamic>? slaEvents;
  final List<dynamic>? subOrders;

  OrderTimelineModel({
    this.id,
    this.orderRef,
    this.customerId,
    this.customerName,
    this.itemsCount,
    this.serviceMode,
    this.serviceType,
    this.addons,
    this.price,
    this.status,
    this.slaStatus,
    this.slaDeadline,
    this.storeId,
    this.assignedFleetId,
    this.pickupOtp,
    this.deliveryOtp,
    this.packetQr,
    this.pickupSlot,
    this.deliverySlot,
    this.pickupTime,
    this.deliveryTime,
    this.qcChecklist,
    this.damageTags,
    this.isSubscription,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.handoffEvents,
    this.qrEvents,
    this.otpEvents,
    this.slaEvents,
    this.subOrders,
  });

  factory OrderTimelineModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDateTime(dynamic value) {
      if (value == null) return null;
      try {
        return DateTime.parse(value.toString());
      } catch (_) {
        return null;
      }
    }

    return OrderTimelineModel(
      id: json['id'] as String?,
      orderRef: json['orderRef'] as String?,
      customerId: json['customerId'] as String?,
      customerName: json['customerName'] as String?,
      itemsCount: json['itemsCount'] as int?,
      serviceMode: json['serviceMode'] as String?,
      serviceType: json['serviceType'] as String?,
      addons: json['addons'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      status: json['status'] as String?,
      slaStatus: json['slaStatus'] as String?,
      slaDeadline: parseDateTime(json['slaDeadline']),
      storeId: json['storeId'] as String?,
      assignedFleetId: json['assignedFleetId'] as String?,
      pickupOtp: json['pickupOtp'] as String?,
      deliveryOtp: json['deliveryOtp'] as String?,
      packetQr: json['packetQr'] as String?,
      pickupSlot: json['pickupSlot'] as String?,
      deliverySlot: json['deliverySlot'] as String?,
      pickupTime: parseDateTime(json['pickupTime']),
      deliveryTime: parseDateTime(json['deliveryTime']),
      qcChecklist: json['qcChecklist'] as List<dynamic>?,
      damageTags: json['damageTags'] as List<dynamic>?,
      isSubscription: json['isSubscription'] as bool?,
      parentId: json['parentId'] as String?,
      createdAt: parseDateTime(json['createdAt']),
      updatedAt: parseDateTime(json['updatedAt']),
      deletedAt: parseDateTime(json['deletedAt']),
      handoffEvents: json['handoffEvents'] as List<dynamic>?,
      qrEvents: json['qrEvents'] != null
          ? (json['qrEvents'] as List<dynamic>)
              .map((e) => QrEventModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      otpEvents: json['otpEvents'] as List<dynamic>?,
      slaEvents: json['slaEvents'] as List<dynamic>?,
      subOrders: json['subOrders'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderRef': orderRef,
      'customerId': customerId,
      'customerName': customerName,
      'itemsCount': itemsCount,
      'serviceMode': serviceMode,
      'serviceType': serviceType,
      'addons': addons,
      'price': price,
      'status': status,
      'slaStatus': slaStatus,
      'slaDeadline': slaDeadline?.toIso8601String(),
      'storeId': storeId,
      'assignedFleetId': assignedFleetId,
      'pickupOtp': pickupOtp,
      'deliveryOtp': deliveryOtp,
      'packetQr': packetQr,
      'pickupSlot': pickupSlot,
      'deliverySlot': deliverySlot,
      'pickupTime': pickupTime?.toIso8601String(),
      'deliveryTime': deliveryTime?.toIso8601String(),
      'qcChecklist': qcChecklist,
      'damageTags': damageTags,
      'isSubscription': isSubscription,
      'parentId': parentId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'handoffEvents': handoffEvents,
      'qrEvents': qrEvents?.map((e) => e.toJson()).toList(),
      'otpEvents': otpEvents,
      'slaEvents': slaEvents,
      'subOrders': subOrders,
    };
  }
}

class QrEventModel {
  final String? id;
  final String? orderId;
  final String? scannedByUserId;
  final String? scannedByRole;
  final String? location;
  final DateTime? createdAt;

  QrEventModel({
    this.id,
    this.orderId,
    this.scannedByUserId,
    this.scannedByRole,
    this.location,
    this.createdAt,
  });

  factory QrEventModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDateTime(dynamic value) {
      if (value == null) return null;
      try {
        return DateTime.parse(value.toString());
      } catch (_) {
        return null;
      }
    }

    return QrEventModel(
      id: json['id'] as String?,
      orderId: json['orderId'] as String?,
      scannedByUserId: json['scannedByUserId'] as String?,
      scannedByRole: json['scannedByRole'] as String?,
      location: json['location'] as String?,
      createdAt: parseDateTime(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'scannedByUserId': scannedByUserId,
      'scannedByRole': scannedByRole,
      'location': location,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
