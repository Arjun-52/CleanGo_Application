import '../entities/order_entity.dart';
import '../../data/models/tracking_model.dart';
import '../repositories/i_order_repository.dart';
import '../../data/models/qr_scan_order_model.dart';

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
}
