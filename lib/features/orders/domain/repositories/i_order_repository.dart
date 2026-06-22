import '../entities/order_entity.dart';
import '../../data/models/tracking_model.dart';
import '../../data/models/qr_scan_order_model.dart';

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
}
