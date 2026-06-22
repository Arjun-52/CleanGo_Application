class CreateOrderRequest {
  final String customerId;
  final String customerName;
  final int itemsCount;
  final String serviceMode;
  final String serviceType;
  final String storeId;

  CreateOrderRequest({
    required this.customerId,
    required this.customerName,
    required this.itemsCount,
    required this.serviceMode,
    required this.serviceType,
    required this.storeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'itemsCount': itemsCount,
      'serviceMode': serviceMode,
      'serviceType': serviceType,
      'storeId': storeId,
    };
  }
}

class CreateOrderResponse {
  final String status;
  final CreateOrderModel? data;

  CreateOrderResponse({
    required this.status,
    this.data,
  });

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponse(
      status: json['status'] as String? ?? '',
      data: json['data'] != null
          ? CreateOrderModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class CreateOrderModel {
  final String? id;
  final String? orderRef;
  final String? customerId;
  final String? customerName;
  final int? itemsCount;
  final String? serviceMode;
  final String? serviceType;
  final String? addons;
  final String? storeId;
  final String? status;
  final String? packetQr;
  final double? price;
  final String? slaStatus;
  final DateTime? slaDeadline;
  final String? assignedFleetId;
  final String? pickupOtp;
  final String? deliveryOtp;
  final String? pickupSlot;
  final String? deliverySlot;
  final DateTime? pickupTime;
  final DateTime? deliveryTime;
  final List<String>? qcChecklist;
  final List<String>? damageTags;
  final bool? isSubscription;
  final String? parentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  CreateOrderModel({
    this.id,
    this.orderRef,
    this.customerId,
    this.customerName,
    this.itemsCount,
    this.serviceMode,
    this.serviceType,
    this.addons,
    this.storeId,
    this.status,
    this.packetQr,
    this.price,
    this.slaStatus,
    this.slaDeadline,
    this.assignedFleetId,
    this.pickupOtp,
    this.deliveryOtp,
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
  });

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) {
    return CreateOrderModel(
      id: json['id'] as String?,
      orderRef: json['orderRef'] as String?,
      customerId: json['customerId'] as String?,
      customerName: json['customerName'] as String?,
      itemsCount: json['itemsCount'] as int?,
      serviceMode: json['serviceMode'] as String?,
      serviceType: json['serviceType'] as String?,
      addons: json['addons'] as String?,
      storeId: json['storeId'] as String?,
      status: json['status'] as String?,
      packetQr: json['packetQr'] as String?,
      price: json['price'] != null ? double.tryParse(json['price'].toString()) ?? 0.0 : null,
      slaStatus: json['slaStatus'] as String?,
      slaDeadline: json['slaDeadline'] != null
          ? DateTime.tryParse(json['slaDeadline'].toString())
          : null,
      assignedFleetId: json['assignedFleetId'] as String?,
      pickupOtp: json['pickupOtp'] as String?,
      deliveryOtp: json['deliveryOtp'] as String?,
      pickupSlot: json['pickupSlot'] as String?,
      deliverySlot: json['deliverySlot'] as String?,
      pickupTime: json['pickupTime'] != null
          ? DateTime.tryParse(json['pickupTime'].toString())
          : null,
      deliveryTime: json['deliveryTime'] != null
          ? DateTime.tryParse(json['deliveryTime'].toString())
          : null,
      qcChecklist: json['qcChecklist'] != null
          ? List<String>.from(json['qcChecklist'] as Iterable)
          : null,
      damageTags: json['damageTags'] != null
          ? List<String>.from(json['damageTags'] as Iterable)
          : null,
      isSubscription: json['isSubscription'] as bool?,
      parentId: json['parentId'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
      deletedAt: json['deletedAt'] != null
          ? DateTime.tryParse(json['deletedAt'].toString())
          : null,
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
      'storeId': storeId,
      'status': status,
      'packetQr': packetQr,
      'price': price,
      'slaStatus': slaStatus,
      'slaDeadline': slaDeadline?.toIso8601String(),
      'assignedFleetId': assignedFleetId,
      'pickupOtp': pickupOtp,
      'deliveryOtp': deliveryOtp,
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
    };
  }
}
