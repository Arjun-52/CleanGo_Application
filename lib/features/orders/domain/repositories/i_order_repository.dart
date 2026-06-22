import '../entities/order_entity.dart';
import '../../data/models/tracking_model.dart';
import '../../data/models/qr_scan_order_model.dart';
import '../../data/models/media_evidence_model.dart';
import '../../data/models/create_order_model.dart';
import '../../data/models/order_timeline_model.dart';

abstract class IOrderRepository {
  Future<List<OrderEntity>> getOrders();
  Future<List<OrderEntity>> getActiveOrders();
  Future<List<OrderEntity>> getPastOrders();
  Future<OrderEntity?> getOrderById(String orderId);
  Future<TrackingModel?> getOrderTracking(String orderId);
  Future<bool> verifyPickupOtp(String orderId, String otp);
  Future<bool> verifyDeliveryOtp(String orderId, String otp);
  Future<bool> cancelOrder(String orderId);
  Future<bool> rateOrder(String orderId, int rating, String? review);
  Future<QrScanOrderModel> scanQrCode(String qrCode);
  Future<MediaEvidenceModel> uploadMediaEvidence({
    required String orderId,
    required String type,
    required String url,
    String? caption,
    bool hasDamage = false,
    bool isSigned = false,
  });
  Future<CreateOrderModel> createOrder({
    required String customerId,
    required String customerName,
    required int itemsCount,
    required String serviceMode,
    required String serviceType,
    required String storeId,
  });
  Future<OrderTimelineModel> getOrderTimeline(String orderId);
}
