import 'package:clean_go/features/orders/data/models/tracking_model.dart';
import '../models/order_model.dart';
import '../../domain/entities/order_entity.dart';
import '../../../../core/network/api_client.dart';
import '../models/qr_scan_order_model.dart';
import '../models/qr_scan_response.dart';
import '../models/media_evidence_model.dart';
import '../models/create_order_model.dart';
import '../models/order_timeline_model.dart';
import '../models/update_processing_stage_request.dart';
import '../models/update_processing_stage_response.dart';

class OrderService {
  final ApiClient apiClient;

  OrderService(this.apiClient);

  /// Get all orders
  Future<List<OrderModel>> getOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [...await getActiveOrders(), ...await getPastOrders()];
  }

  /// Active Orders
  Future<List<OrderModel>> getActiveOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      OrderModel(
        id: "CLN-2026-001",
        userId: "user123",
        items: [
          OrderItem(
            serviceId: "1",
            serviceName: "Wash & Iron",
            quantity: 2,
            price: 95,
          ),
        ],
        totalAmount: 95,
        status: OrderStatus.inProgress,
        pickupOtp: "1234",
        deliveryOtp: "5678",
        pickupTime: DateTime.now(),
        deliveryTime: DateTime.now().add(const Duration(days: 2)),
        addressId: "address1",
        createdAt: DateTime.now(),
      ),
    ];
  }

  /// Past Orders (THIS FIXES YOUR SCREEN)
  Future<List<OrderModel>> getPastOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      OrderModel(
        id: "CLN-2026-001",
        userId: "user123",
        items: [
          OrderItem(
            serviceId: "1",
            serviceName: "Wash & Iron",
            quantity: 2,
            price: 95,
          ),
        ],
        totalAmount: 95,
        status: OrderStatus.processing,
        pickupOtp: "1234",
        deliveryOtp: "5678",
        pickupTime: DateTime.now().subtract(const Duration(days: 2)),
        deliveryTime: DateTime.now().subtract(const Duration(days: 1)),
        addressId: "address1",
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),

      OrderModel(
        id: "CLN-2026-002",
        userId: "user123",
        items: [
          OrderItem(
            serviceId: "2",
            serviceName: "Dry Clean",
            quantity: 6,
            price: 95,
          ),
        ],
        totalAmount: 95,
        status: OrderStatus.processing,
        pickupOtp: "2222",
        deliveryOtp: "3333",
        pickupTime: DateTime.now().subtract(const Duration(days: 5)),
        deliveryTime: DateTime.now().subtract(const Duration(days: 4)),
        addressId: "address2",
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),

      OrderModel(
        id: "CLN-2026-003",
        userId: "user123",
        items: [
          OrderItem(
            serviceId: "3",
            serviceName: "Steam Iron",
            quantity: 4,
            price: 95,
          ),
        ],
        totalAmount: 95,
        status: OrderStatus.delivered,
        pickupOtp: "4444",
        deliveryOtp: "5555",
        pickupTime: DateTime.now().subtract(const Duration(days: 8)),
        deliveryTime: DateTime.now().subtract(const Duration(days: 7)),
        addressId: "address3",
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
      ),
    ];
  }

  /// Get order by ID
  Future<OrderModel?> getOrderById(String orderId) async {
    await Future.delayed(const Duration(seconds: 1));

    return OrderModel(
      id: orderId,
      userId: "user123",
      items: [
        OrderItem(
          serviceId: "1",
          serviceName: "Wash & Iron",
          quantity: 5,
          price: 499,
        ),
        OrderItem(
          serviceId: "2",
          serviceName: "Dry Clean",
          quantity: 2,
          price: 300,
        ),
      ],
      totalAmount: 799,
      status: OrderStatus.inProgress,
      pickupOtp: "5646",
      deliveryOtp: "7890",
      pickupTime: DateTime.now().subtract(const Duration(days: 1)),
      deliveryTime: DateTime.now().add(const Duration(days: 1)),
      addressId: "address123",
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    );
  }

  /// Order Tracking
  Future<TrackingModel?> getOrderTracking(String orderId) async {
    return null;
  }

  Future<bool> verifyPickupOtp(String orderId, String otp) async {
    return true;
  }

  Future<bool> verifyDeliveryOtp(String orderId, String otp) async {
    return true;
  }

  Future<bool> cancelOrder(String orderId) async {
    return true;
  }

  Future<bool> rateOrder(String orderId, int rating, String? review) async {
    return true;
  }

  /// Scan QR Code API
  Future<QrScanOrderModel> scanQrCode(String qrCode) async {
    try {
      final response = await apiClient.post(
        '/api/orders/qr/scan',
        data: {
          'packetQr': qrCode,
          'location': 'Pickup Point - MG Road',
        },
      );
      if (response.data is Map<String, dynamic>) {
        final scanResponse = QrScanResponse.fromJson(response.data as Map<String, dynamic>);
        if (scanResponse.status == 'success' && scanResponse.data != null) {
          return scanResponse.data!;
        } else {
          throw Exception(scanResponse.message.isNotEmpty ? scanResponse.message : "Failed to scan QR code");
        }
      }
      throw Exception("Invalid response format from server");
    } catch (e) {
      print("DEBUG: scanQrCode error: $e");
      rethrow;
    }
  }

  /// Upload QC Evidence Media
  Future<MediaEvidenceModel> uploadMediaEvidence({
    required String orderId,
    required String type,
    required String url,
    String? caption,
    bool hasDamage = false,
    bool isSigned = false,
  }) async {
    try {
      final request = MediaEvidenceUploadRequest(
        orderId: orderId,
        type: type,
        url: url,
        caption: caption,
        hasDamage: hasDamage,
        isSigned: isSigned,
      );

      final response = await apiClient.post(
        '/api/media/upload',
        data: request.toJson(),
      );

      if (response.data is Map<String, dynamic>) {
        final uploadResponse = MediaEvidenceUploadResponse.fromJson(response.data as Map<String, dynamic>);
        if (uploadResponse.status == 'success' && uploadResponse.data != null) {
          return uploadResponse.data!;
        } else {
          throw Exception(uploadResponse.message.isNotEmpty ? uploadResponse.message : "Failed to upload evidence");
        }
      }
      throw Exception("Invalid response format from server");
    } catch (e) {
      print("DEBUG: uploadMediaEvidence error: $e");
      rethrow;
    }
  }

  /// Create Order API
  Future<CreateOrderModel> createOrder({
    required String customerId,
    required String customerName,
    required int itemsCount,
    required String serviceMode,
    required String serviceType,
    required String storeId,
  }) async {
    try {
      final request = CreateOrderRequest(
        customerId: customerId,
        customerName: customerName,
        itemsCount: itemsCount,
        serviceMode: serviceMode,
        serviceType: serviceType,
        storeId: storeId,
      );

      final response = await apiClient.post(
        '/api/orders',
        data: request.toJson(),
      );

      if (response.data is Map<String, dynamic>) {
        final createResponse = CreateOrderResponse.fromJson(response.data as Map<String, dynamic>);
        if (createResponse.status == 'success' && createResponse.data != null) {
          return createResponse.data!;
        } else {
          throw Exception("Failed to create order");
        }
      }
      throw Exception("Invalid response format from server");
    } catch (e) {
      print("DEBUG: createOrder error: $e");
      rethrow;
    }
  }

  /// Get Order Timeline API
  Future<OrderTimelineModel> getOrderTimeline(String orderId) async {
    try {
      final response = await apiClient.get(
        '/api/orders/$orderId',
      );

      if (response.data is Map<String, dynamic>) {
        final timelineResponse = OrderTimelineResponse.fromJson(response.data as Map<String, dynamic>);
        if (timelineResponse.status == 'success' && timelineResponse.data != null) {
          return timelineResponse.data!;
        } else {
          throw Exception(timelineResponse.message.isNotEmpty ? timelineResponse.message : "Failed to fetch order timeline");
        }
      }
      throw Exception("Invalid response format from server");
    } catch (e) {
      print("DEBUG: getOrderTimeline error: $e");
      rethrow;
    }
  }

  /// Update Processing Stage API
  Future<UpdateProcessingStageResponse> updateProcessingStage(String orderId, String status) async {
    try {
      final request = UpdateProcessingStageRequest(status: status);
      final response = await apiClient.patch(
        '/api/orders/$orderId',
        data: request.toJson(),
      );

      if (response.data is Map<String, dynamic>) {
        return UpdateProcessingStageResponse.fromJson(response.data as Map<String, dynamic>);
      }
      throw Exception("Invalid response format from server");
    } catch (e) {
      print("DEBUG: updateProcessingStage error: $e");
      rethrow;
    }
  }
}
