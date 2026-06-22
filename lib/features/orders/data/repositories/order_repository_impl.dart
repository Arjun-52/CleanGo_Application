import '../models/tracking_model.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/i_order_repository.dart';
import '../datasources/order_service.dart';
import '../models/qr_scan_order_model.dart';
import '../models/media_evidence_model.dart';
import '../models/create_order_model.dart';
import '../models/order_timeline_model.dart';
import '../models/update_processing_stage_response.dart';

class OrderRepositoryImpl implements IOrderRepository {
  final OrderService remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<OrderEntity>> getOrders() async {
    final orders = await remoteDataSource.getOrders();
    return orders.map((order) => order.toEntity()).toList();
  }

  @override
  Future<List<OrderEntity>> getActiveOrders() async {
    final orders = await remoteDataSource.getActiveOrders();
    return orders.map((order) => order.toEntity()).toList();
  }

  @override
  Future<List<OrderEntity>> getPastOrders() async {
    final orders = await remoteDataSource.getPastOrders();
    return orders.map((order) => order.toEntity()).toList();
  }

  @override
  Future<OrderEntity?> getOrderById(String orderId) async {
    final order = await remoteDataSource.getOrderById(orderId);
    return order?.toEntity();
  }

  @override
  Future<TrackingModel?> getOrderTracking(String orderId) {
    return remoteDataSource.getOrderTracking(orderId);
  }

  @override
  Future<bool> verifyPickupOtp(String orderId, String otp) {
    return remoteDataSource.verifyPickupOtp(orderId, otp);
  }

  @override
  Future<bool> verifyDeliveryOtp(String orderId, String otp) {
    return remoteDataSource.verifyDeliveryOtp(orderId, otp);
  }

  @override
  Future<bool> cancelOrder(String orderId) {
    return remoteDataSource.cancelOrder(orderId);
  }

  @override
  Future<bool> rateOrder(String orderId, int rating, String? review) {
    return remoteDataSource.rateOrder(orderId, rating, review);
  }

  @override
  Future<QrScanOrderModel> scanQrCode(String qrCode) {
    return remoteDataSource.scanQrCode(qrCode);
  }

  @override
  Future<MediaEvidenceModel> uploadMediaEvidence({
    required String orderId,
    required String type,
    required String url,
    String? caption,
    bool hasDamage = false,
    bool isSigned = false,
  }) {
    return remoteDataSource.uploadMediaEvidence(
      orderId: orderId,
      type: type,
      url: url,
      caption: caption,
      hasDamage: hasDamage,
      isSigned: isSigned,
    );
  }

  @override
  Future<CreateOrderModel> createOrder({
    required String customerId,
    required String customerName,
    required int itemsCount,
    required String serviceMode,
    required String serviceType,
    required String storeId,
  }) {
    return remoteDataSource.createOrder(
      customerId: customerId,
      customerName: customerName,
      itemsCount: itemsCount,
      serviceMode: serviceMode,
      serviceType: serviceType,
      storeId: storeId,
    );
  }

  @override
  Future<OrderTimelineModel> getOrderTimeline(String orderId) {
    return remoteDataSource.getOrderTimeline(orderId);
  }

  @override
  Future<UpdateProcessingStageResponse> updateProcessingStage({
    required String orderId,
    required String status,
  }) {
    return remoteDataSource.updateProcessingStage(orderId, status);
  }
}
