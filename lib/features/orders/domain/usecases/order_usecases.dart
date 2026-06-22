import '../entities/order_entity.dart';
import '../../data/models/tracking_model.dart';
import '../repositories/i_order_repository.dart';
import '../../data/models/qr_scan_order_model.dart';
import '../../data/models/media_evidence_model.dart';
import '../../data/models/create_order_model.dart';
import '../../data/models/order_timeline_model.dart';

class OrderUseCases {
  final IOrderRepository repository;

  OrderUseCases(this.repository);

  Future<List<OrderEntity>> getOrders() {
    return repository.getOrders();
  }

  Future<List<OrderEntity>> getActiveOrders() {
    return repository.getActiveOrders();
  }

  Future<List<OrderEntity>> getPastOrders() {
    return repository.getPastOrders();
  }

  Future<OrderEntity?> getOrderById(String orderId) {
    return repository.getOrderById(orderId);
  }

  Future<TrackingModel?> getOrderTracking(String orderId) {
    return repository.getOrderTracking(orderId);
  }

  Future<bool> verifyPickupOtp(String orderId, String otp) {
    return repository.verifyPickupOtp(orderId, otp);
  }

  Future<bool> verifyDeliveryOtp(String orderId, String otp) {
    return repository.verifyDeliveryOtp(orderId, otp);
  }

  Future<bool> cancelOrder(String orderId) {
    return repository.cancelOrder(orderId);
  }

  Future<bool> rateOrder(String orderId, int rating, String? review) {
    return repository.rateOrder(orderId, rating, review);
  }

  Future<QrScanOrderModel> scanQrCode(String qrCode) {
    return repository.scanQrCode(qrCode);
  }

  Future<MediaEvidenceModel> uploadMediaEvidence({
    required String orderId,
    required String type,
    required String url,
    String? caption,
    bool hasDamage = false,
    bool isSigned = false,
  }) {
    return repository.uploadMediaEvidence(
      orderId: orderId,
      type: type,
      url: url,
      caption: caption,
      hasDamage: hasDamage,
      isSigned: isSigned,
    );
  }

  Future<CreateOrderModel> createOrder({
    required String customerId,
    required String customerName,
    required int itemsCount,
    required String serviceMode,
    required String serviceType,
    required String storeId,
  }) {
    return repository.createOrder(
      customerId: customerId,
      customerName: customerName,
      itemsCount: itemsCount,
      serviceMode: serviceMode,
      serviceType: serviceType,
      storeId: storeId,
    );
  }

  Future<OrderTimelineModel> getOrderTimeline(String orderId) {
    return repository.getOrderTimeline(orderId);
  }
}
